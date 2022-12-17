import 'package:bloc/bloc.dart';
import 'package:bsccs/models/books_tab_data.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'book_screen_state.dart';

class BooksScreenCubit extends Cubit<BooksScreenState> {
  final CsRepository _csRepository;

  BooksScreenCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const BooksScreenState()) {
    getSemesterInfo();
  }

  void getSemesterInfo() {
    _csRepository.getCourseInfo().then((value) {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;
      _getTabsData(sem, courseName);

      emit(state.copyWith(
        semesters: sem,
        apiStatus: false,
        courseName: courseName,
      ));
    });
  }

  void _getTabsData(int semesters, String courseName) {
    _csRepository.getCourseInfo();
  }
}
