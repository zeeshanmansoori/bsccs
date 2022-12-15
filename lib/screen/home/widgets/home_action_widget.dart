import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class HomeActionWidget extends StatelessWidget {
  const HomeActionWidget({
    Key? key,
    required this.homeAction,
  }) : super(key: key);
  final HomeAction homeAction;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(15);
    return Card(
      color: CustomColors.actionColor,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: cardBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.primaryColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              homeAction.iconData,
              color: Colors.white,
            ),
          ),
          Text(
            homeAction.title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ).asButton(
        onTap: () {},
        borderRadius: cardBorderRadius,
      ),
    );
  }
}
