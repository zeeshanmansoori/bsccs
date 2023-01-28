import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final CsRepository _csRepository;
  SettingsCubit(this._csRepository) : super(const SettingsState());


  void onSemesterChanged(int? value) {
    emit(state.copyWith(selectedSemester: value));
  }

  void saveSelectedSemester() {
    var sem = state.selectedSemester;
    if(sem==null)return;
    _csRepository.saveSelectedSemester(sem);
  }
}
