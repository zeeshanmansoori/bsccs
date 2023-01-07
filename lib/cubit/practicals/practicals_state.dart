part of 'practicals_cubit.dart';

class PracticalsState extends Equatable {

  final String message;
  final Map<int, List<AddWrapper>> tabsData;

  @override
  List<Object?> get props => [
        message,
        tabsData,
      ];

  const PracticalsState({
    this.message = "",
    this.tabsData = const {},
  });

  PracticalsState copyWith({
    String? message,
    Map<int, List<AddWrapper>>? tabsData,
  }) {
    return PracticalsState(
      message: message ?? this.message,
      tabsData: tabsData ?? this.tabsData,
    );
  }
}
