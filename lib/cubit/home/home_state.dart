part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserDetails? userInfo;
  final List<AppNotification>? notifications;

  @override
  List<Object?> get props => [
        userInfo,
        notifications?.length,
      ];

  const HomeState({
    this.userInfo,
    this.notifications,
  });

  HomeState copyWith({
    UserDetails? userInfo,
    List<AppNotification>? notifications,
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
      notifications: notifications ?? this.notifications,
    );
  }
}
