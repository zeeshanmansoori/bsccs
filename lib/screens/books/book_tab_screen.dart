import 'package:bsccs/cubit/books/book_screen_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/screens/books/widget/book_tab_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class BookTabScreen extends StatelessWidget {
  const BookTabScreen({
    Key? key,
    required this.tabIndex,
    required this.onClicked,
  }) : super(key: key);

  final int tabIndex;
  final Function(CourseBook book) onClicked;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksScreenCubit, BooksScreenState>(
      builder: (context, state) {
        List<AddWrapper>? addWrapperData = state.tabsData[tabIndex];
        if (addWrapperData == null) {
          return const CircularProgressIndicator().wrapCenter();
        }

        if (addWrapperData.isEmpty) {
          return const EmptyStateWidget();
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
          children:
              addWrapperData.map((e) => mapBookPageDataToWidget(e)).toList(),
        );
      },
    );
  }

  Widget mapBookPageDataToWidget(AddWrapper data) {
    if (data is AddWrapperData<CourseBook>) {
      return BookTabItemWidget(
        book: data.item,
        onClicked: () => onClicked.call(data.item),
      );
    }
    if (data is AddWrapperAd) {
      return CsBannerAd.resizableAdBox();
    }
    return Container(
      color: Colors.blue,
      width: 200,
      height: 100,
    );
  }
}
