import 'package:bloc/bloc.dart';
import 'package:bsccs/use_case/auth_use_case.dart';
import 'package:cs_repository/src/cs_repo.dart';
import 'package:cs_shared_preferences/cs_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  final AuthUseCase _authUseCase;
  final CsRepository _csRepository;

  AuthScreenCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        _authUseCase = AuthUseCase(),
        super(const AuthScreenState());

  void login() async {
    if (state.progressBarVisible) return;
    emit(state.copyWith(progressBarVisible: true));
    _authUseCase.signInWithGoogle().then(
      (value) {
        var user = value.user;
        var name = user?.displayName ?? "";
        var image = user?.photoURL ?? "";
        var email = user?.email ?? "";
        var userId = user?.uid ?? "";

        _csRepository.saveUserInfo(
          userId,
          name,
          image,
          email,
        );

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
