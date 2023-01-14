import 'dart:developer';

import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/firebase_options.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/screens/add_note/add_note_screen.dart';
import 'package:bsccs/screens/authGate/auth_gate.dart';
import 'package:bsccs/screens/books/books_screen.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/screens/notes/notes_screen.dart';
import 'package:bsccs/screens/practicals/practicals_screen.dart';
import 'package:bsccs/screens/questions/questions_screen.dart';
import 'package:bsccs/screens/syllabus/syllabus_screen.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/notification_storage_util.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  _saveMessage(message);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   _saveMessage(message);
  // });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _saveMessage(message);
  });
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  messaging.subscribeToTopic("global");
  runApp(MyApp(csRepository: CsRepository()));
}

void _saveMessage(RemoteMessage message) {
  log("zeeshan title ${message.notification?.title}"
      " data ${message.notification?.body} "
      "${message.notification?.android?.imageUrl}"
      "${message.data}");

  var type = message.data["type"];
  var id = message.data["id"];
  var notification = message.notification;
  if (type == "course" && notification != null) {
    var appNotification = AppNotification.from(
      title: notification.title,
      description: notification.body,
      image: notification.android?.imageUrl,
      type: type,
      id: id,
    );
    NotificationStorageUtil.saveNotification(appNotification)
        .then((value) => print("zeeshan success "))
        .onError(
            (error, stackTrace) => print("zeeshan failure trace $stackTrace"));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.csRepository,
  });

  final CsRepository csRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (ctx) => csRepository),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Bsc Cs',
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: CustomColors.primaryColor,
          iconTheme: const IconThemeData(color: CustomColors.primaryColor),
        ),
        home: BlocProvider(
          create: (context) =>
              AuthGateCubit(context.read<CsRepository>())..init(),
          child: BlocBuilder<AuthGateCubit, AuthGateState>(
            builder: (context, state) {
              return const AuthGate();
            },
          ),
        ),
        routes: {
          BooksScreen.routeName: (ctx) => const BooksScreen(),
          SyllabusScreen.routeName: (ctx) => const SyllabusScreen(),
          QuestionsScreen.routeName: (ctx) => const QuestionsScreen(),
          NotesScreen.routeName: (ctx) => const NotesScreen(),
          PracticalsScreen.routeName: (ctx) => const PracticalsScreen(),
          FreeCoursesScreen.routeName: (ctx) => const FreeCoursesScreen(),
          AddNoteScreen.routeName: (ctx) => const AddNoteScreen(),
        },
      ),
    );
  }
}
