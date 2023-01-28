part of 'free_courses_cubit.dart';

class FreeCoursesState extends Equatable {
  final FormzStatus status;
  final String msg;
  final List<AddWrapper> courses;

  @override
  List<Object?> get props => [
        status,
        msg,
        courses,
      ];

  const FreeCoursesState({
    this.status = FormzStatus.submissionInProgress,
    this.msg = "",
    this.courses = const [],
  });

  FreeCoursesState copyWith({
    FormzStatus? status,
    String? msg,
    List<AddWrapper>? courses,
  }) {
    return FreeCoursesState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      courses: courses ?? this.courses,
    );
  }
}
