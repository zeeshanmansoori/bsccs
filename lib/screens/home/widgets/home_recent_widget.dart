import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/models/home_recent.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class HomeRecentWidget extends StatelessWidget {
  const HomeRecentWidget({
    Key? key,
    required this.homeRecent,
  }) : super(key: key);
  final HomeRecent homeRecent;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    return Card(
      color: CustomColors.actionColor,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: CustomColors.primaryColor,
                  borderRadius: BorderRadius.circular(Constants.cardRadius)),
            ).paddingForOnly(right: 10).expanded(flex: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${homeRecent.title}\n",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).paddingForOnly(top: 2),
                Text(homeRecent.description,style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),).paddingForOnly(top: 10),
              ],
            ).expanded(flex: 2)
          ],
        ).paddingForAll(10).asButton(
              onTap: () {},
              borderRadius: cardBorderRadius,
            ),
      ),
    );
  }
}
