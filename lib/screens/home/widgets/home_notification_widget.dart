import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class HomeNotificationWidget extends StatelessWidget {
  const HomeNotificationWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    return Card(
      color: CustomColors.actionColor,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.cardRadius),
            ),
            child: Image.network(
              notification.image ?? "",
              errorBuilder: (ctx, object, trace) => Container(
                color: CustomColors.primaryColor,
              ),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                notification.description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ).paddingForOnly(top: 2),
            ],
          ).paddingForOnly(left: 10, top: 2)
        ],
      )
          .paddingForOnly(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          )
          .asButton(
            onTap: () {
              if (notification.type == AppNotificationType.course) {
                Navigator.pushNamed(context, FreeCoursesScreen.routeName);
              }
            },
            borderRadius: cardBorderRadius,
          ),
    );
  }
}
