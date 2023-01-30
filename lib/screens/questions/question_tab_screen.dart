import 'package:bsccs/cubit/questions/questions_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:bsccs/screens/pdf_screen/pdf_screen.dart';
import 'package:bsccs/screens/questions/widget/question_paper_tab_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
        List<ListWrapper<QuestionPaper>>? addWrapperData =
            state.tabsData[tabIndex];
        if (addWrapperData == null) {
          return const CircularProgressIndicator().wrapCenter();
        }

        if (addWrapperData.isEmpty) {
          return const EmptyStateWidget();
        }
        return Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return QuestionPaperTabItemWidget(
                  questionPapers: addWrapperData[index],
                  onClicked: (paper) {
                    PdfScreen.navigate(context, paper.link);
                  },
                );
              },
              itemCount: addWrapperData.length,
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              physics: const BouncingScrollPhysics(),
            ).expanded(flex: 1),
            const CsBannerAd(
              adSize: AdSize.largeBanner,
            ).paddingForOnly(bottom: 20)
          ],
        );
      },
    );
  }
}
