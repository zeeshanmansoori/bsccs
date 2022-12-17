import 'dart:developer';

import 'package:bsccs/cubit/books_screen/book_screen_cubit.dart';
import 'package:bsccs/screen/books/book_tab_screen.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class BooksScreen extends StatelessWidget {
  static const String routeName = "/books_screen";

  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksScreenCubit(context.read<CsRepository>()),
      child: BlocBuilder<BooksScreenCubit, BooksScreenState>(
        buildWhen: (p, c) => p.apiStatus != c.apiStatus,
        builder: (context, state) {
          var tabCount = state.semesters ?? 0;
          var isLoading = state.apiStatus;
          return DefaultTabController(
            initialIndex: state.defaultSem - 1,
            length: tabCount,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                titleSpacing: 0,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: List.generate(
                    tabCount,
                    (index) => Text(
                      "Semester ${index + 1}",
                      style: const TextStyle(color: Colors.black),
                    ).paddingWithSymmetry(vertical: 10),
                  ).toList(),
                ),
                title: const Text(
                  'Tabs Demo',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: isLoading
                  ? const CircularProgressIndicator().wrapCenter()
                  : TabBarView(
                      children: List.generate(
                        tabCount,
                        (index) => BookTabScreen(
                          semester: index + 1,
                          courseName: state.courseName!,
                          onClicked: (book) => navigateToPdf(context, book),
                        ),
                      ).toList(),
                    ),
            ),
          );
        },
      ),
    );
  }

  void navigateToPdf(BuildContext context, CourseBook book) {
    Navigator.pushNamed(context, routeName);
  }
}
