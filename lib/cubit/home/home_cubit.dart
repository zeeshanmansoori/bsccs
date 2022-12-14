import 'package:bloc/bloc.dart';
import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/screens/books/books_screen.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/screens/notes/notes_screen.dart';
import 'package:bsccs/screens/practicals/practicals_screen.dart';
import 'package:bsccs/screens/questions/questions_screen.dart';
import 'package:bsccs/screens/syllabus/syllabus_screen.dart';
import 'package:bsccs/utils/bsc_cs_app_icons.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

import '../../models/app_notification.dart';

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
      destinationName: QuestionsScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.notes,
      title: "Notes",
      destinationName: NotesScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.practicals,
      title: "Practicals",
      destinationName: PracticalsScreen.routeName,
    ),
    const HomeAction(
      iconData: BscCsApp.freeCourses,
      title: "Free Courses",
      destinationName: FreeCoursesScreen.routeName,
    ),
  ];

  HomeCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const HomeState()) {
    _fetchUserInfo();
    _fetchNotifications();
  }

  void _fetchUserInfo() async {
    UserDetails? result = await _csRepository.getUserInfo();
    emit(state.copyWith(userInfo: result));
  }

  void _fetchNotifications() async {
    emit(state.copyWith(notifications: _getDummyNotifications()));
  }

  List<AppNotification> _getDummyNotifications() {
    return List.generate(
      10,
      (index) => AppNotification(
        title: "title $index",
        image: "",
        type: "",
        isRead: false,
      ),
    );
  }
}
