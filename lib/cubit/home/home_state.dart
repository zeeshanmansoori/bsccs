part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserDetails? userInfo;

  @override
  List<Object?> get props => [userInfo];

  const HomeState({
    this.userInfo,
  });

  HomeState copyWith({
    UserDetails? userInfo,
  }) {
    return HomeState(
      userInfo: userInfo ?? this.userInfo,
    );
  }
}
