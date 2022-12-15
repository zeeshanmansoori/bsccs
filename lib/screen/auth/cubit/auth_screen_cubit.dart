import 'package:bloc/bloc.dart';
import 'package:bsccs/use_case/auth_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  late final AuthUseCase authUseCase;

  AuthScreenCubit() : super(const AuthScreenState()) {
    authUseCase = AuthUseCase();
  }

  void login() async {
    if (state.progressBarVisible) return;
    emit(state.copyWith(progressBarVisible: true));
    authUseCase.signInWithGoogle().then(
      (value) {
        emit(state.copyWith(
          navigate: true,
          progressBarVisible: false,
        ));
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          errorMsg: error.toString(),
          progressBarVisible: false,
        ));
      },
    );
  }

  void clearMsg() {
    emit(state.copyWith(errorMsg: ""));
  }
}
