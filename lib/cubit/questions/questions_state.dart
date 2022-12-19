part of 'questions_cubit.dart';

class QuestionsState extends Equatable {
  final int? semesters;
  final bool isLoading;
  final String message;
  final int defaultSem;
  final List<QuestionTabData> tabsData;
  final String? courseName;

  @override
  List<Object?> get props => [
    semesters,
    isLoading,
    message,
    defaultSem,
    tabsData,
    courseName,
  ];

  const QuestionsState({
    this.semesters,
    this.isLoading = true,
    this.message = "",
    this.defaultSem = 2,
    this.tabsData = const [],
    this.courseName,
  });

  QuestionsState copyWith({
    int? semesters,
    bool? isLoading,
    String? message,
    int? defaultSem,
    List<QuestionTabData>? tabsData,
    String? courseName,
  }) {
    return QuestionsState(
      semesters: semesters ?? this.semesters,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      defaultSem: defaultSem ?? this.defaultSem,
      tabsData: tabsData ?? this.tabsData,
      courseName: courseName ?? this.courseName,
    );
  }
}


