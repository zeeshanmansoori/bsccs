import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/firebase_options.dart';
import 'package:bsccs/screens/add_note/add_note_screen.dart';
import 'package:bsccs/screens/authGate/auth_gate.dart';
import 'package:bsccs/screens/books/books_screen.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/screens/notes/notes_screen.dart';
import 'package:bsccs/screens/practicals/practicals_screen.dart';
import 'package:bsccs/screens/questions/questions_screen.dart';
import 'package:bsccs/screens/syllabus/syllabus_screen.dart';
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
        title: 'Bsc Cs',
        theme: ThemeData(
          fontFamily: 'Inter',
          primarySwatch: CustomColors.primaryColor,
          iconTheme: const IconThemeData(color: CustomColors.primaryColor),
        ),
        home: BlocProvider(
          create: (context) =>
          AuthGateCubit(context.read<CsRepository>())
            ..init(),
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
