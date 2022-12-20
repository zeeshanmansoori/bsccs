import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/src/question_paper.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final CsRepository _csRepository;

  QuestionsCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const QuestionsState()) {
    _init();
  }

  void _init() {
    _csRepository.getCourseInfo().then((value) async {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;


      emit(state.copyWith(
        semesters: sem,
        isLoading: false,
        courseName: courseName,
        isPaperLoading: true,
      ));

      List<ListWrapper<BookQuestions>> data = [];
      for (var i = 0; i < sem; ++i) {
        var questionPapers = await _getTabsData(i+1, courseName);
        log("zeeshan $questionPapers");
        data.add(ListWrapper(items: questionPapers));
      }
      emit(state.copyWith(
        tabsData: data,
        isPaperLoading: false,
      ));
    });
  }

  Future<List<BookQuestions>> _getTabsData(int semester, String courseName) {
    return _csRepository.getQuestionPapers(semester, courseName);
  }
}
