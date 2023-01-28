part of 'questions_cubit.dart';

class QuestionsState extends Equatable {

  final String message;
  final Map<int, List<ListWrapper<QuestionPaper>>> tabsData;

  @override
  List<Object?> get props => [
        message,
        tabsData,
      ];

  const QuestionsState({
    this.message = "",
    this.tabsData = const {},
  });

  QuestionsState copyWith({
    String? message,
    Map<int, List<ListWrapper<QuestionPaper>>>? tabsData,
  }) {
    return QuestionsState(
      message: message ?? this.message,
      tabsData: tabsData ?? this.tabsData,
    );
  }
}
