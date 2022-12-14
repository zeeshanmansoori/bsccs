part of 'auth_screen_cubit.dart';

class AuthScreenState extends Equatable {
  final String errorMsg;
  final bool navigate;
  final bool progressBarVisible;

  @override
  List<Object?> get props => [errorMsg];

  const AuthScreenState({
    this.errorMsg = "",
    this.navigate = false,
    this.progressBarVisible = false,
  });

  AuthScreenState copyWith({
    String? errorMsg,
    bool? navigate,
    bool? progressBarVisible,
  }) {
    return AuthScreenState(
      errorMsg: errorMsg ?? this.errorMsg,
      navigate: navigate ?? this.navigate,
      progressBarVisible: progressBarVisible ?? this.progressBarVisible,
    );
  }
}
