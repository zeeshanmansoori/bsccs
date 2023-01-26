import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'semester_selection_state.dart';

class SemesterSelectionCubit extends Cubit<SemesterSelectionState> {
  final CsRepository _csRepository;

  SemesterSelectionCubit(this._csRepository)
      : super(const SemesterSelectionState()) {
    _init();
  }

  void _init() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    var result = await _csRepository.getCourseInfo();
    if (isClosed) {
      return;
    }
    emit(state.copyWith(
      semesterCount: result?.semesters,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void onSemesterChanged(int? semester) {
    emit(state.copyWith(selectedSemester: semester));
  }

  void saveSelectedSemester() {
    var sem = state.selectedSemester;
    if(sem==null)return;
    _csRepository.saveSelectedSemester(sem);
  }
}
