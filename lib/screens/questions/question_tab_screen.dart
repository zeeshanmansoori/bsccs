import 'package:bsccs/cubit/questions/questions_cubit.dart';
import 'package:bsccs/custom_widgets/ad_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/question_paper_list_wrapper.dart';
import 'package:bsccs/screens/questions/widget/question_paper_tab_item_widget.dart';
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
  final Function(QuestionPaper book) onClicked;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        List<AddWrapper>? addWrapperData = state.tabsData[tabIndex];
        if (addWrapperData == null) {
          return const CircularProgressIndicator().wrapCenter();
        }

        if (addWrapperData.isEmpty) {
         return const EmptyStateWidget();
        }
        return ListView.builder(
          itemBuilder: (context, index) =>
              mapBookPageDataToWidget(addWrapperData[index]),
          itemCount: addWrapperData.length,
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
        );
      },
    );
  }

  Widget mapBookPageDataToWidget(AddWrapper data) {
    if (data is AddWrapperData<QuestionPaperListWrapper>) {
      return QuestionPaperTabItemWidget(
        questionPaper: data.item,
        onClicked: () {},
      );
    }
    if (data is AddWrapperAd) {
      return const AdWidget();
    }

    return Container(color: Colors.blue,width: 200,height: 100,);
  }
}
