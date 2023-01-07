import 'package:bsccs/models/app_notification.dart';
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
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(Constants.cardRadius),
            ),
          ),
          Text(
            "${notification.title}\n",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).paddingForOnly(left: 10,top: 2)
        ],
      )
          .paddingForOnly(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          )
          .asButton(
            onTap: () {},
            borderRadius: cardBorderRadius,
          ),
    );
  }
}
