import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final CsRepository _csRepository;

  SettingsCubit(this._csRepository) : super(const SettingsState()) {
    _init();
  }

  void _init() async {
    emit(
      state.copyWith(
          selectedSemester: await _csRepository.getDefaultSemester(),
          offlineModeEnabled: await _csRepository.getOfflineMode()),
    );
  }

  void onSemesterChanged(int? value) {
    emit(state.copyWith(selectedSemester: value));
  }

  void onOfflineModeToggleChanged(bool value) {
    _csRepository.setOfflineMode(value);
    emit(state.copyWith(offlineModeEnabled: value));
  }

  void saveSelectedSemester() {
    var sem = state.selectedSemester;
    if (sem == null) return;
    _csRepository.saveSelectedSemester(sem);
  }
}
