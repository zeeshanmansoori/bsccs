import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/cubit/home/home_cubit.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/books/books_screen.dart';
import 'package:bsccs/screens/free_courses/free_courses_screen.dart';
import 'package:bsccs/screens/practicals/practicals_screen.dart';
import 'package:bsccs/screens/questions/questions_screen.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(Constants.cardRadius);
    var cubit = context.read<AuthGateCubit>();
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
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(Constants.cardRadius),
            ),
            child: Image.network(
              notification.image ?? "",
              errorBuilder: (ctx, object, trace) => const Icon(
                CupertinoIcons.bell_fill,
                color: Colors.white,
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
              var argument = GlobalArguments(
                courseName: cubit.state.courseName!,
                semesterCount: cubit.state.semesters!,
                defaultSemester: cubit.getDefaultSem(),
              );
              switch (notification.type) {
                case AppNotificationType.course:
                  Navigator.pushNamed(context, FreeCoursesScreen.routeName);
                  break;
                case AppNotificationType.books:
                  BooksScreen.navigate(context, argument);
                  break;
                case AppNotificationType.practicals:
                  PracticalsScreen.navigate(context, argument);
                  break;
                case AppNotificationType.questionPapers:
                  QuestionsScreen.navigate(context, argument);
                  break;
                default:
                  break;
              }
            },
            borderRadius: cardBorderRadius,
          ),
    );
  }
}
