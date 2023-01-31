import 'package:bsccs/cubit/notifications/notifications_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:bsccs/screens/home/widgets/home_notification_widget.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllNotificationScreen extends StatelessWidget {
  static const routeName = "/notifications";

  const AllNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifications =
        ModalRoute.of(context)?.settings.arguments as List<AddWrapper>?;
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: Scaffold(
        appBar: WidgetUtils.csAppBar(titleText: "Notifications"),
        body: Builder(
          builder: (ctx) {
            if (notifications == null || notifications.isEmpty) {
              return const EmptyStateWidget(
                message: "No notification found",
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, index) {
                var notif = notifications[index];
                if (notif is AddWrapperData<AppNotification>) {
                  return NotificationWidget(notification: notif.item);
                }
                return const CsBannerAd();
              },
              itemCount: notifications.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            );
          },
        ),
      ),
    );
  }
}
