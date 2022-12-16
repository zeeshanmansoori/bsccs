import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'books_screen_state.dart';

class BooksScreenCubit extends Cubit<BooksScreenState> {
  final CsRepository _csRepository;

  BooksScreenCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const BooksScreenState()) {
    getSemesterInfo();
  }

  void getSemesterInfo() {
    _csRepository.getCourseInfo().then((value) {
      var sem = value?.semesters;
      emit(state.copyWith(
        semesters: sem,
        apiStatus: false,
      ));
    });
  }
}
