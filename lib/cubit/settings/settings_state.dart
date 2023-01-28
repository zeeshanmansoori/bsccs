part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final int? selectedSemester;

  @override
  List<Object?> get props => [selectedSemester];

  const SettingsState({
    this.selectedSemester,
  });

  SettingsState copyWith({
    int? selectedSemester,
  }) {
    return SettingsState(
      selectedSemester: selectedSemester ?? this.selectedSemester,
    );
  }
}
