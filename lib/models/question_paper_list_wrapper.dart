import 'package:shared_repository/shared_repo.dart';

class QuestionPaperListWrapper{
  final String subjectId;
  final String subjectName;
  final List<QuestionPaper> items;

  const QuestionPaperListWrapper({
    required this.subjectId,
    required this.subjectName,
    required this.items,
  });
}