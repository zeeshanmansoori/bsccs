part of 'auth_gate_cubit.dart';

class AuthGateState extends Equatable {
  final bool? isLoggedIn;
  final int? semesters;
  final FormzStatus status;
  final String message;
  final String? courseName;
  final bool? hasInternet;
  final bool? previouslyHasInternet;

  @override
  List<Object?> get props => [
        isLoggedIn,
        semesters,
        status,
        message,
        courseName,
        hasInternet,
    previouslyHasInternet,
      ];

  const AuthGateState({
    this.isLoggedIn,
    this.semesters,
    this.status = FormzStatus.pure,
    this.message = "",
    this.courseName,
    this.hasInternet,
    this.previouslyHasInternet,
  });

  AuthGateState copyWith({
    bool? isLoggedIn,
    int? semesters,
    FormzStatus? status,
    String? message,
    String? courseName,
    bool? hasInternet,
    bool? previouslyHasInternet,
  }) {
    return AuthGateState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      semesters: semesters ?? this.semesters,
      status: status ?? this.status,
      message: message ?? this.message,
      courseName: courseName ?? this.courseName,
      hasInternet: hasInternet ?? this.hasInternet,
      previouslyHasInternet: previouslyHasInternet ?? this.previouslyHasInternet,
    );
  }
}
