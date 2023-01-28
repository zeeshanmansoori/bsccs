import 'package:bloc/bloc.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/utils/extension/extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final CsRepository _csRepo;

  NoteCubit(this._csRepo) : super(const NoteState()) {
    fetchNotes();
  }

  void fetchNotes() async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      var notes = await _csRepo.getNotes();
      emit(state.copyWith(
        notes: notes.toAddWrapperList(),
        status: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        msg: e.toString(),
        status: FormzStatus.submissionFailure,
      ));
    }
  }
}
