part of 'syllabus_cubit.dart';

class SyllabusState extends Equatable {
  final bool isLoading;
  final List<dynamic> syllabus;

  @override
  List<Object> get props => [
        isLoading,
        syllabus,
      ];

  const SyllabusState({
    this.isLoading = false,
    this.syllabus = const [],
  });

  SyllabusState copyWith({
    bool? isLoading,
    List<dynamic>? syllabus,
  }) {
    return SyllabusState(
      isLoading: isLoading ?? this.isLoading,
      syllabus: syllabus ?? this.syllabus,
    );
  }
}
