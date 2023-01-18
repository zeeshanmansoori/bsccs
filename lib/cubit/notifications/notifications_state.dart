part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final List<AppNotification>? notifications;

  const NotificationsState({
    this.notifications,
  });

  @override
  List<Object?> get props => [
        notifications,
      ];

  NotificationsState copyWith({
    List<AppNotification>? notifications,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
    );
  }
}
