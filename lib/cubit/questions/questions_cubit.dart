import 'package:bloc/bloc.dart';
import 'package:bsccs/models/question_tab_data.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final CsRepository _csRepository;

  QuestionsCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const QuestionsState()) {
    _init();
  }

  void _init() {
    _csRepository.getCourseInfo().then((value) {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;
      _getTabsData(sem, courseName);

      emit(state.copyWith(
        semesters: sem,
        isLoading: false,
        courseName: courseName,
      ));
    });
  }

  void _getTabsData(int semesters, String courseName) {
    _csRepository.getCourseInfo();
  }
}
