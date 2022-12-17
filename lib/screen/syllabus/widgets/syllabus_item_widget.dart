import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/extension.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_repository/shared_repo.dart';

class SyllabusItemWidget extends StatelessWidget {
  const SyllabusItemWidget({
    Key? key,
    required this.syllabus,
    required this.onClicked,
  }) : super(key: key);

  final CourseSyllabus syllabus;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(Constants.cardRadius);
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withOpacity(.5),
        borderRadius: radius,
      ),
      child: Text(
        syllabus.name.capitalize(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ).wrapCenter(),
    ).asButton(
      onTap: onClicked,
      borderRadius: radius,
    );
  }
}
