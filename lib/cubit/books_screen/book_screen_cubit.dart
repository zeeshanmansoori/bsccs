import 'package:bloc/bloc.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/src/course_book.dart';

part 'book_screen_state.dart';

class BooksScreenCubit extends Cubit<BooksScreenState> {
  final CsRepository _csRepository;

  BooksScreenCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const BooksScreenState()) {
    _getSemesterInfo();
  }

  void _getSemesterInfo() {
    _csRepository.getCourseInfo().then((value) async {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;

      emit(state.copyWith(
        semesters: sem,
        apiStatus: false,
        courseName: courseName,
        isBookLoading: true,
      ));

      List<ListWrapper<CourseBook>> booksTab = [];
      for (var i = 0; i < sem; ++i) {
        var books = await _getBooks(i + 1, courseName);
        booksTab.add(ListWrapper(items: books));
      }

      emit(state.copyWith(
        tabBooks: booksTab,
        isBookLoading: false,
      ));
    });
  }

  Future<List<CourseBook>> _getBooks(
    int semester,
    String courseName,
  ) async {
    return await _csRepository.getBooks(
      semester,
      courseName,
    );
  }
}
