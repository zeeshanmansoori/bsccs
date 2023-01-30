import 'dart:math';

import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/cubit/home/home_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/all_notification/all_notification_screen.dart';
import 'package:bsccs/screens/home/widgets/home_action_widget.dart';
import 'package:bsccs/screens/home/widgets/home_notification_widget.dart';
import 'package:bsccs/screens/semester_selection/semester_selection_btm_sheet.dart';
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
    var authCubit = context.read<AuthGateCubit>();
    return BlocProvider(
      create: (context) => HomeCubit(context.read<CsRepository>()),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.displayBtmSheet == true) {
            var cubit = context.read<HomeCubit>();
            cubit.updateDisplayBtmSheet(false);
            SemesterSelectionBtmSheet.show(context, cubit);
          }
        },
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
                  position: PopupMenuPosition.under,
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text("Settings"),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Logout"),
                    )
                  ],
                  onSelected: (value) {
                    if (value == 0) {
                      SettingsScreen.navigate(
                        context,
                        authCubit.state.semesters!,
                      );
                      return;
                    }
                    if (value == 1) {
                      WidgetUtils.showAlertDialog(
                        context,
                        title: "Logout",
                        description: "Are you sure you want to logout?",
                        onConfirmClicked: () async {
                          authCubit.logOut();
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
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
                          onClicked: () async => Navigator.pushNamed(
                            context,
                            action.destinationName,
                            arguments: GlobalArguments(
                              courseName: context
                                  .read<AuthGateCubit>()
                                  .state
                                  .courseName!,
                              semesterCount: context
                                  .read<AuthGateCubit>()
                                  .state
                                  .semesters!,
                              defaultSemester:
                                  (await cubit.getDefaultSem()) ?? 1,
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
                      itemBuilder: (ctx, index) {
                        var item = notifications[index];
                        if (item is AddWrapperData<AppNotification>) {
                          return NotificationWidget(notification: item.item)
                              .paddingWithSymmetry(horizontal: 15);
                        }
                        return const CsBannerAd().paddingWithSymmetry(horizontal: 15);
                      },
                      itemCount: size,
                    );
                  },
                ).paddingForOnly(bottom: 20).expanded(flex: 1),
              ],
            ),
          );
        }),
      ),
    );
  }
}
