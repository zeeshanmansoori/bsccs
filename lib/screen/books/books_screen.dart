import 'package:bsccs/cubit/books_screen_cubit.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            length: tabCount,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                titleSpacing: 0,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: List.generate(
                    tabCount,
                    (index) => Tab(icon: Icon(Icons.directions_car)),
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
                  ? CircularProgressIndicator().wrapCenter()
                  : TabBarView(
                      children: List.generate(
                        tabCount,
                        (index) => Tab(icon: Icon(Icons.directions_car)),
                      ).toList(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
