import 'package:bsccs/cubit/practicals/practicals_cubit.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/pdf_screen/pdf_screen.dart';
import 'package:bsccs/screens/practicals/practicals_tab_screen.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticalsScreen extends StatelessWidget {
  static const String routeName = "/practicals_screen";

  const PracticalsScreen({Key? key}) : super(key: key);

  static void navigate(BuildContext context, GlobalArguments argument) {
    Navigator.pushNamed(context, routeName, arguments: argument);
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as GlobalArguments;
    var tabCount = arguments.semesterCount;
    var defaultSem = arguments.defaultSemester;
    var courseName = arguments.courseName;

    return BlocProvider(
      create: (context) => PracticalsCubit(
        context.read<CsRepository>(),
        semesterCount: tabCount,
        courseName: courseName,
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
            titleText: "Practicals",
          ),
          body: TabBarView(
            children: List.generate(
              tabCount,
              (index) => PracticalsTabScreen(
                tabIndex: index,
                onClicked: (book) => PdfScreen.navigate(context, book.link),
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
