part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final int? selectedSemester;
  final bool offlineModeEnabled;

  @override
  List<Object?> get props => [
        selectedSemester,
        offlineModeEnabled,
      ];

  const SettingsState({
    this.selectedSemester,
    this.offlineModeEnabled = false,
  });

  SettingsState copyWith({
    int? selectedSemester,
    bool? offlineModeEnabled,
  }) {
    return SettingsState(
      selectedSemester: selectedSemester ?? this.selectedSemester,
      offlineModeEnabled: offlineModeEnabled ?? this.offlineModeEnabled,
    );
  }
}
