import 'package:bsccs/cubit/books_screen/tab/book_tab_cubit.dart';
import 'package:bsccs/custom_widgets/ad_widget.dart';
import 'package:bsccs/screen/books/widget/book_tab_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class BookTabScreen extends StatelessWidget {
  const BookTabScreen({
    Key? key,
    required this.semester,
    required this.courseName,
    required this.onClicked,
  }) : super(key: key);

  final int semester;
  final String courseName;
  final Function(CourseBook book) onClicked;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookTabCubit(
        context.read<CsRepository>(),
        semester: semester,
        courseName: courseName,
      ),
      child: BlocBuilder<BookTabCubit, BookTabState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator().wrapCenter();
          }
          var items = state.books;
          if (items.isEmpty) {
            return const Text("empty screen").wrapCenter();
          }
          return GridView.count(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 20,
            ),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: .7,
            crossAxisCount: 2,
            children: items.map((e) => mapBookPageDataToWidget(e)).toList(),
          );
        },
      ),
    );
  }

  Widget mapBookPageDataToWidget(dynamic data) {
    if (data is CourseBook) {
      return BookTabItemWidget(
        book: data,
        onClicked: () => onClicked.call(data),
      );
    }

    return Column(
      children: [
        const AdWidget().expanded(flex: 1),
        const Text(
          "Add\n",
          style: TextStyle(fontWeight: FontWeight.w500),
          maxLines: 2,
        ).paddingForOnly(top: 10),
      ],
    );
  }
}
