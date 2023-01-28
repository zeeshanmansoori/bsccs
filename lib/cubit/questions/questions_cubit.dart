import 'package:bloc/bloc.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:collection/collection.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final CsRepository _csRepository;
  final String courseName;
  final int semesterCount;

  QuestionsCubit(
    CsRepository csRepository, {
    required this.courseName,
    required this.semesterCount,
  })  : _csRepository = csRepository,
        super(const QuestionsState()) {
    _init();
  }

  void _init() async {
    var map = Map.from(state.tabsData);
    for (var i = 0; i < semesterCount; ++i) {
      _getTabsData(i + 1, courseName).then((questionPapers) {
        var groupedData = groupBy(questionPapers, (s) => s.subjectId);
        var list = groupedData
            .map(
              (key, value) => MapEntry(
                key,
                ListWrapper<QuestionPaper>(
                  subjectId: key,
                  subjectName: value.first.subjectName,
                  items: value,
                ),
              ),
            )
            .values
            .toList();

        map[i] = list.toList();
        emit(state.copyWith(
          tabsData: Map.unmodifiable(map),
        ));
      });
    }
  }

  Future<List<QuestionPaper>> _getTabsData(int semester, String courseName) {
    return _csRepository.getQuestionPapers(semester, courseName);
  }
}
