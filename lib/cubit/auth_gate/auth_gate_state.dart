part of 'auth_gate_cubit.dart';

class AuthGateState extends Equatable {
  final bool? isLoggedIn;
  final int? semesters;
  final bool apiStatus;
  final String message;
  final int defaultSem;
  final String? courseName;
  final bool? hasInternet;
  final bool? previouslyHasInternet;

  @override
  List<Object?> get props => [
        isLoggedIn,
        semesters,
        apiStatus,
        message,
        defaultSem,
        courseName,
        hasInternet,
    previouslyHasInternet,
      ];

  const AuthGateState({
    this.isLoggedIn,
    this.semesters,
    this.apiStatus = true,
    this.message = "",
    this.defaultSem = 1,
    this.courseName,
    this.hasInternet,
    this.previouslyHasInternet,
  });

  AuthGateState copyWith({
    bool? isLoggedIn,
    int? semesters,
    bool? apiStatus,
    String? message,
    int? defaultSem,
    String? courseName,
    bool? hasInternet,
    bool? previouslyHasInternet,
  }) {
    return AuthGateState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      semesters: semesters ?? this.semesters,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      defaultSem: defaultSem ?? this.defaultSem,
      courseName: courseName ?? this.courseName,
      hasInternet: hasInternet ?? this.hasInternet,
      previouslyHasInternet: previouslyHasInternet ?? this.previouslyHasInternet,
    );
  }
}
