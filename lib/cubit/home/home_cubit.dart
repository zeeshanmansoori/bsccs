import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/screens/books/books_screen.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/screens/notes/notes_screen.dart';
import 'package:bsccs/screens/practicals/practicals_screen.dart';
import 'package:bsccs/screens/questions/questions_screen.dart';
import 'package:bsccs/screens/syllabus/syllabus_screen.dart';
import 'package:bsccs/utils/bsc_cs_app_icons.dart';
import 'package:bsccs/utils/notification_storage_util.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CsRepository _csRepository;
  StreamSubscription<Map<String, dynamic>>? _subscription;

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
    NotificationStorageUtil.registerListener(_onNotificationAdded);
  }

  void _onNotificationAdded(String notificationId) {
    if (!isClosed) {
      List<AppNotification> notifications = [];
      notifications.addAll(state.notifications ?? []);
      var notification =
          NotificationStorageUtil.getNotification(notificationId);
      notifications.add(notification);
      emit(state.copyWith(notifications: notifications));
    }
  }

  void _fetchUserInfo() async {
    UserDetails? result = await _csRepository.getUserInfo();
    emit(
      state.copyWith(
        userInfo: result,
        displayBtmSheet: result.mySemester == -1,
      ),
    );
  }

  void _fetchNotifications() async {
    NotificationStorageUtil.getIsReady().then((isReady) {
      if (!isReady) return;
      _subscription =
          NotificationStorageUtil.getNotificationsAsStream().listen((event) {
        if (isClosed) return;
        List<AppNotification> notifications = [];
        for (var element in event.entries) {
          notifications.add(AppNotification.fromMap(element.value));
        }

        emit(state.copyWith(notifications: notifications));
      });
    });
  }

  void _closeStreams() {
    NotificationStorageUtil.unRegisterListener();
    NotificationStorageUtil.closeStream();
    _subscription?.cancel();
  }

  @override
  Future<void> close() {
    _closeStreams();
    return super.close();
  }

  void updateDisplayBtmSheet(bool btmSheet) {
    emit(state.copyWith(displayBtmSheet: btmSheet));
  }

  void updateSelectedSemester(int? selectedSemester) {
    emit(
      state.copyWith(
        userInfo: state.userInfo?.copyWith(
          mySemester: selectedSemester,
        ),
      ),
    );
  }

  Future<int?> getDefaultSem() {
    return _csRepository.getDefaultSemester();
  }
}
