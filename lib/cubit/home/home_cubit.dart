import 'package:bloc/bloc.dart';
import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/screen/books/books_screen.dart';
import 'package:bsccs/utils/bsc_cs_app_icons.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

import '../../screen/syllabus/syllabus_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CsRepository _csRepository;
  final List<HomeAction> homeActions = [
    const HomeAction(
      iconData: BscCsApp.books,
      title: "Books",
      destinationName: BooksScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.syllabus,
      title: "Syllabus",
      destinationName: SyllabusScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.questions,
      title: "Questions",
      destinationName: BooksScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.notes,
      title: "Notes",
      destinationName: BooksScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.practicals,
      title: "Practicals",
      destinationName: BooksScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.freeCourses,
      title: "Free Courses",
      destinationName: BooksScreen.routeName,
    ),
  ];

  HomeCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const HomeState()) {
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    UserDetails? result = await _csRepository.getUserInfo();
    emit(state.copyWith(userInfo: result));
  }
}