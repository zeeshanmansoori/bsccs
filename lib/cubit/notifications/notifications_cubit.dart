import 'package:bloc/bloc.dart';
import 'package:bsccs/models/app_notification.dart';
import 'package:equatable/equatable.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());
}
