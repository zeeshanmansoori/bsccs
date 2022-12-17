import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class BookTabItemWidget extends StatelessWidget {
  const BookTabItemWidget({
    Key? key,
    required this.book,
    required this.onClicked,
  }) : super(key: key);

  final CourseBook book;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius  =  BorderRadius.circular(Constants.cardRadius);
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
                book.imageLink,
                fit: BoxFit.cover,
                width: constraints.maxWidth,
              );
            }),
          ),
        ).expanded(flex: 1),
        Text(
          "${book.name}\n",
          style: const TextStyle(fontWeight: FontWeight.w500),
          maxLines: 2,
        ).paddingForOnly(top: 10),
      ],
    ).asButton(
          onTap: onClicked,
          borderRadius: cardBorderRadius,
        );
  }
}
