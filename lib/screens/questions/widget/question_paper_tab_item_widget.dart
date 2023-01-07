import 'package:bsccs/models/list_wrapper.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class QuestionPaperTabItemWidget extends StatelessWidget {
  const QuestionPaperTabItemWidget({
    Key? key,
    required this.questionPaper,
    required this.onClicked,
  }) : super(key: key);

  final ListWrapper questionPaper;
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
        children: questionPaper.items
            .mapIndexed((index, e) => QuestionPaperWidget(
                  e,
                  index,
                  questionPaper.items.length,
                  onClicked: onPaperClicked,
                ))
            .toList(),
      ).paddingForOnly(
        top: 10,
      ),
    );
  }

  void onPaperClicked(QuestionPaper paper) {}
}

class QuestionPaperWidget extends StatelessWidget {
  final QuestionPaper _questionPaper;
  final int index;
  final int size;

  const QuestionPaperWidget(
    QuestionPaper questionPaper,
    this.index,
    this.size, {
    Key? key,
    required this.onClicked,
  })  : _questionPaper = questionPaper,
        super(key: key);
  final Function(QuestionPaper paper) onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(colors: [
            CustomColors.primaryColor.withOpacity(.9),
            CustomColors.primaryColor.withOpacity(.4),
          ])),
      child: Text(
        "Year : ${_questionPaper.timeStamp}",
        style: const TextStyle(
          color: Colors.white,
        ),
      ).paddingForOnly(left: 10, top: 10, bottom: 10),
    )
        .asButton(onTap: () => onClicked.call(_questionPaper))
        .paddingWithSymmetry(vertical: 4);
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   child: Text("Year : ${_questionPaper.timeStamp}")
    //       .paddingForOnly(left:10,top: 10,bottom: 10)
    //
    // );
  }
}
