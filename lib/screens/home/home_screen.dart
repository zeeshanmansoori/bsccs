import 'dart:math';

import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/cubit/home/home_cubit.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/all_notification/all_notification_screen.dart';
import 'package:bsccs/screens/home/widgets/home_action_widget.dart';
import 'package:bsccs/screens/home/widgets/home_notification_widget.dart';
import 'package:bsccs/screens/settings_screen/settings_screen.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(context.read<CsRepository>()),
      child: Builder(builder: (context) {
        var cubit = context.read<HomeCubit>();

        return Scaffold(
          appBar: WidgetUtils.csAppBar(
            title: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Text(
                  "👋, ${state.userInfo?.userName}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ).paddingForOnly(left: 20);
              },
            ),
            actions: [
              IconButton(
                splashRadius: Constants.splashRadius,
                onPressed: () {},
                icon: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var image = state.userInfo?.image ?? "";
                    return CircleAvatar(
                      backgroundImage:
                          image.isEmpty ? null : NetworkImage(image),
                    );
                  },
                ),
              ),
              PopupMenuButton(
                splashRadius: Constants.splashRadius,
                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text("Settings"),
                  ),
                ],
                onSelected: (value) => Navigator.pushNamed(
                  context,
                  SettingsScreen.routeName,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: cubit.homeActions
                    .map(
                      (action) => HomeActionWidget(
                        homeAction: action,
                        onClicked: () => Navigator.pushNamed(
                          context,
                          action.destinationName,
                          arguments: GlobalArguments(
                            courseName:
                                context.read<AuthGateCubit>().state.courseName!,
                            semesterCount:
                                context.read<AuthGateCubit>().state.semesters!,
                            defaultSemester:
                                context.read<AuthGateCubit>().state.defaultSem,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ).paddingWithSymmetry(vertical: 30, horizontal: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AllNotificationScreen.routeName,
                        arguments: cubit.state.notifications,
                      );
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ).paddingWithSymmetry(horizontal: 20),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  var notifications = state.notifications ?? [];
                  var size = min(4, notifications.length);

                  if (notifications.isEmpty) {
                    return const EmptyStateWidget(
                      message: "No notification found",
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) =>
                        NotificationWidget(notification: notifications[index])
                            .paddingWithSymmetry(horizontal: 15),
                    itemCount: size,
                  );
                },
              ).paddingForOnly(bottom: 20).expanded(flex: 1),
            ],
          ),
        );
      }),
    );
  }
}
