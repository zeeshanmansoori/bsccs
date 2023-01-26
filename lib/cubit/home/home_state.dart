part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserDetails? userInfo;
  final List<AppNotification>? notifications;
  final bool? displayBtmSheet;

  @override
  List<Object?> get props => [
        userInfo,
        notifications?.length,
        displayBtmSheet,
      ];

  const HomeState({
    this.userInfo,
    this.notifications,
    this.displayBtmSheet,
  });

  HomeState copyWith({
    UserDetails? userInfo,
    List<AppNotification>? notifications,
    bool? displayBtmSheet,
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
      notifications: notifications ?? this.notifications,
      displayBtmSheet: displayBtmSheet ?? this.displayBtmSheet,
    );
  }
}
