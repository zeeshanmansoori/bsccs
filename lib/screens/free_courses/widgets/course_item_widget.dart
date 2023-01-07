import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class CourseItemWidget extends StatelessWidget {
  const CourseItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius / 2);
    var courseName = "google data analytics";
    var courseFrom = "from Meta";
    return Card(
      color: CustomColors.actionColor,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
              borderRadius: cardBorderRadius,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).paddingForOnly(top: 40),
                  Text(
                    courseFrom,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ).paddingForOnly(top: 10, bottom: 20)
                ],
              ).paddingForOnly(left: 10),
              Positioned(
                top: -25,
                left: 10,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: cardBorderRadius,
                  ),
                ),
              )
            ],
          ),
        ],
      ).asButton(
        onTap: () {},
        borderRadius: cardBorderRadius,
      ),
    );
  }
}
