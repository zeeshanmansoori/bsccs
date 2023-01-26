part of 'semester_selection_cubit.dart';

class SemesterSelectionState extends Equatable {
  final FormzStatus status;
  final String msg;
  final int? semesterCount;
  final int? selectedSemester;

  @override
  List<Object?> get props => [
        status,
        msg,
        semesterCount,
        selectedSemester,
      ];

  const SemesterSelectionState({
    this.status = FormzStatus.pure,
    this.msg = "",
    this.semesterCount,
    this.selectedSemester,
  });

  SemesterSelectionState copyWith({
    FormzStatus? status,
    String? msg,
    int? semesterCount,
    int? selectedSemester,
  }) {
    return SemesterSelectionState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      semesterCount: semesterCount ?? this.semesterCount,
      selectedSemester: selectedSemester ?? this.selectedSemester,
    );
  }
}
