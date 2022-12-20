part of 'questions_cubit.dart';

class QuestionsState extends Equatable {
  final int? semesters;
  final bool isLoading;
  final bool isPaperLoading;
  final String message;
  final int defaultSem;
  final List<ListWrapper<BookQuestions>> tabsData;
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
    this.isPaperLoading = false,
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
    List<ListWrapper<BookQuestions>>? tabsData,
    String? courseName,
    bool? isPaperLoading,
  }) {
    return QuestionsState(
      semesters: semesters ?? this.semesters,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      defaultSem: defaultSem ?? this.defaultSem,
      tabsData: tabsData ?? this.tabsData,
      courseName: courseName ?? this.courseName,
      isPaperLoading: isPaperLoading ?? this.isPaperLoading,
    );
  }
}
