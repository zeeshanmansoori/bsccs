import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  final CsRepository _csRepo;

  AddNoteCubit(this._csRepo) : super(const AddNoteState());

  void saveNote(String jsonEncode, String plainText, {String? noteId}) async {
    var plain = plainText.replaceAll("\n", "");
    if (plain.replaceAll("\n", "").isEmpty) {
      updateMsg("Please enter text.");
      return;
    }

    var title = plainText.split("\n").first;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var result = await _csRepo.saveNotes(
        title,
        jsonEncode,
        noteId: noteId,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, msg: e.toString()));
    }
  }

  void updateMsg(String msg) {
    emit(state.copyWith(msg: msg));
  }
}
