import 'package:bsccs/firebase_options.dart';
import 'package:bsccs/screen/authGate/auth_gate.dart';
import 'package:bsccs/screen/books/books_screen.dart';
import 'package:bsccs/screen/questions/questions_screen.dart';
import 'package:bsccs/screen/syllabus/syllabus_screen.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(csRepository: CsRepository()));
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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: CustomColors.primaryColor,
          iconTheme: const IconThemeData(color: CustomColors.primaryColor),
        ),
        home: const AuthGate(),
        routes: {
          BooksScreen.routeName: (ctx) => const BooksScreen(),
          SyllabusScreen.routeName: (ctx) => const SyllabusScreen(),
          QuestionsScreen.routeName: (ctx) => const QuestionsScreen(),
        },
      ),
    );
  }
}
