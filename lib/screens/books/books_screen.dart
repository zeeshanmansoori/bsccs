import 'package:bsccs/cubit/books/book_screen_cubit.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/books/book_tab_screen.dart';
import 'package:bsccs/screens/pdf_screen/pdf_screen.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksScreen extends StatefulWidget {
  static const String routeName = "/books_screen";

  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();

  static void navigate(BuildContext context, GlobalArguments globalArguments) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: globalArguments,
    );
  }
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    var homeArgument =
        ModalRoute.of(context)?.settings.arguments as GlobalArguments;
    var tabCount = homeArgument.semesterCount;
    var defaultSem = homeArgument.defaultSemester;
    var courseName = homeArgument.courseName;

    return BlocProvider(
      create: (context) => BooksScreenCubit(
        context.read<CsRepository>(),
        courseName: courseName,
        semesterCount: tabCount,
      ),
      child: DefaultTabController(
        initialIndex: defaultSem - 1,
        length: tabCount,
        child: Scaffold(
          appBar: WidgetUtils.csAppBar(
            bottom: TabBar(
              isScrollable: true,
              tabs: List.generate(
                tabCount,
                (index) => Text(
                  "Semester ${index + 1}",
                ).paddingWithSymmetry(vertical: 10),
              ).toList(),
            ),
            titleText: "Books",
          ),
          body: TabBarView(
            children: List.generate(
              tabCount,
              (index) => BookTabScreen(
                tabIndex: index,
                onClicked: (book) => PdfScreen.navigate(context, book.link),
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
