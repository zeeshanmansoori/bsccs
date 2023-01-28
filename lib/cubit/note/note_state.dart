part of 'note_cubit.dart';

class NoteState extends Equatable {
  final List<AddWrapper> notes;
  final FormzStatus status;
  final String msg;

  @override
  List<Object> get props => [
        notes,
        status,
        msg,
      ];

  const NoteState({
    this.notes = const [],
    this.status = FormzStatus.pure,
    this.msg = "",
  });

  NoteState copyWith({
    List<AddWrapper>? notes,
    FormzStatus? status,
    String? msg,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      msg: msg ?? this.msg,
    );
  }
}
