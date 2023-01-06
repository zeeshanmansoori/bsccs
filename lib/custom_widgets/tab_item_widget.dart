import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({
    Key? key,
    required this.title,
    required this.imageLink,
    required this.onClicked,
    this.titleMaxLines = 1,
  }) : super(key: key);

  final String title;
  final String imageLink;
  final Function onClicked;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
          borderRadius: cardBorderRadius,
          child: Container(
            color: CustomColors.actionColor,
            child: LayoutBuilder(builder: (context, constraints) {
              return Image.network(
                imageLink,
                fit: BoxFit.cover,
                width: constraints.maxWidth,
              );
            }),
          ),
        ).expanded(flex: 1),
        Text(
          "$title\n",
          style: const TextStyle(fontWeight: FontWeight.w500),
          maxLines: titleMaxLines,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ).paddingForAll(10),
      ],
    ).asButton(
      onTap: onClicked,
      borderRadius: cardBorderRadius,
    );
  }
}
