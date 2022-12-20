import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class QuestionPaperTabItemWidget extends StatelessWidget {
  const QuestionPaperTabItemWidget({
    Key? key,
    required this.questionPaper,
    required this.onClicked,
  }) : super(key: key);

  final BookQuestions questionPaper;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    return ExpandablePanel(
      theme: ExpandableThemeData(
        useInkWell: true,
        inkWellBorderRadius: cardBorderRadius,
      ),
      header: Text(
        "${questionPaper.subjectName}\n",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ).paddingForOnly(left: 10, top: 10),
      collapsed: const Divider(),
      expanded: Column(
        children: questionPaper.links
            .map((e) => QuestionPaperWidget(
                  e,
                  onClicked: onPaperClicked,
                ))
            .toList(),
      ).paddingForOnly(
        left: 10,
        top: 10,
      ),
    );
  }

  void onPaperClicked(QuestionPaper paper) {}
}

class QuestionPaperWidget extends StatelessWidget {
  final QuestionPaper _questionPaper;

  const QuestionPaperWidget(
    QuestionPaper questionPaper, {
    Key? key,
    required this.onClicked,
  })  : _questionPaper = questionPaper,
        super(key: key);
  final Function(QuestionPaper paper) onClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text("Year : ${_questionPaper.timeStamp}")
          .paddingWithSymmetry(vertical: 10)
          .asButton(onTap: () => onClicked.call(_questionPaper)),
    );
  }
}
