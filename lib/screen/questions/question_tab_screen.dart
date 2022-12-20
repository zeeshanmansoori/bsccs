import 'package:bsccs/cubit/questions/questions_cubit.dart';
import 'package:bsccs/custom_widgets/ad_widget.dart';
import 'package:bsccs/screen/questions/widget/question_paper_tab_item_widget.dart';
import 'package:bsccs/utils/extension/extension.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class QuestionTabScreen extends StatelessWidget {
  const QuestionTabScreen({
    Key? key,
    required this.tabIndex,
    required this.onClicked,
  }) : super(key: key);

  final int tabIndex;
  final Function(BookQuestions book) onClicked;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        if (state.isPaperLoading) {
          return const CircularProgressIndicator().wrapCenter();
        }
        var tabData = state.tabsData.getOrNull(tabIndex);
        var items = tabData == null?[]:tabData.items;
        if (items.isEmpty) {
          return const Text("Empty screen").wrapCenter();
        }
        return ListView.builder(
          itemBuilder: (context, index) =>
              mapBookPageDataToWidget(items[index]),
          itemCount: items.length,
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
            bottom: 20,
          ),

        );


      },
    );
  }

  Widget mapBookPageDataToWidget(dynamic data) {
    if (data is BookQuestions) {
      return QuestionPaperTabItemWidget(
        questionPaper: data,
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
