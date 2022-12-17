import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'book_tab_state.dart';

class BookTabCubit extends Cubit<BookTabState> {
  final int semester;
  final String courseName;
  final CsRepository _csRepository;

  BookTabCubit(
    CsRepository csRepository, {
    required this.semester,
    required this.courseName,
  })  : _csRepository = csRepository,
        super(const BookTabState()) {
    // _getBooks();
    _dummyBooks();
  }

  void _getBooks() async {
    var books = await _csRepository.getBooks(
      semester,
      courseName,
    );
    emit(state.copyWith(
      books: books,
      isLoading: false,
    ));
  }

  void _dummyBooks() {
    List<BookPageData> list = List.generate(
      5,
      (index) => CourseBook(
        link: "asd",
        imageLink:
            "https://mdpi-res.com/bookfiles/book/5003/The_Convergence_of_Human_and_Artificial_Intelligence_on_Clinical_Care__Part_I.jpg?v1668436724",
        name: "Aritifical Intelligence",
      ) as BookPageData,
    ).toList();

    list.add(GoogleAdd());

    emit(state.copyWith(
      books: list,
      isLoading: false,
    ));
  }
}
