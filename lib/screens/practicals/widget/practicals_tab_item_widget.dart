import 'package:bsccs/models/list_wrapper.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class PracticalsTabItemWidget extends StatelessWidget {
  const PracticalsTabItemWidget({
    Key? key,
    required this.practical,
    required this.onClicked,
  }) : super(key: key);

  final ListWrapper<Practical> practical;
  final Function(Practical) onClicked;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);

    return ExpandablePanel(
      theme: ExpandableThemeData(
        useInkWell: true,
        inkWellBorderRadius: cardBorderRadius,
      ),
      header: Text(
        "${practical.subjectName}\n",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ).paddingForOnly(left: 10, top: 10),
      collapsed: const Divider(),
      expanded: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 2,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        children: practical.items
            .mapIndexed(
              (index, e) => PracticalItemWidget(
                e,
                onClicked: onClicked,
              ),
            )
            .toList(),
      ),
    );
  }

}

class PracticalItemWidget extends StatelessWidget {
  final Practical practical;

  const PracticalItemWidget(
    this.practical, {
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  final Function(Practical paper) onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          colors: [
            CustomColors.primaryColor.withOpacity(.8),
            CustomColors.primaryColor.withOpacity(.5),
          ],
        ),
      ),
      child: Text(
        "P ${practical.practicalNumber}",
        style: const TextStyle(
          color: Colors.white,
        ),
      ).wrapCenter(),
    )
        .asButton(onTap: () => onClicked.call(practical))
        .paddingWithSymmetry(vertical: 4);
  }
}
