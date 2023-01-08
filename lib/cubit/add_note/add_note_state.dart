part of 'add_note_cubit.dart';

class AddNoteState extends Equatable {
  final String msg;
  final FormzStatus status;

  @override
  List<Object> get props => [
        msg,
        status,
      ];

  const AddNoteState({
    this.msg = "",
    this.status = FormzStatus.pure,
  });

  AddNoteState copyWith({
    String? msg,
    FormzStatus? status,
  }) {
    return AddNoteState(
      msg: msg ?? this.msg,
      status: status ?? this.status,
    );
  }
}
