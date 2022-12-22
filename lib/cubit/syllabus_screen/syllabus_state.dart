part of 'syllabus_cubit.dart';

class SyllabusState extends Equatable {
  final bool isLoading;
  final List<CourseSyllabus> syllabus;


  @override
  List<Object> get props => [
        isLoading,
        syllabus,
      ];

  const SyllabusState({
    this.isLoading = true,
    this.syllabus = const [],
  });

  SyllabusState copyWith({
    bool? isLoading,
    List<CourseSyllabus>? syllabus,
  }) {
    return SyllabusState(
      isLoading: isLoading ?? this.isLoading,
      syllabus: syllabus ?? this.syllabus,
    );
  }
}
