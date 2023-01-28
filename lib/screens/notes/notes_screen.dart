import 'package:bsccs/cubit/note/note_cubit.dart';
import 'package:bsccs/custom_widgets/adbox_widget.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/screens/add_note/add_note_screen.dart';
import 'package:bsccs/utils/custom_colors.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shared_repository/shared_repo.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(context.read<CsRepository>()),
      child: Scaffold(
        appBar: WidgetUtils.csAppBar(titleText: "Notes"),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AddNoteScreen.navigate(context),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<NoteCubit, NoteState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            var cubit = context.read<NoteCubit>();
            if (state.status.isSubmissionInProgress) {
              return const CircularProgressIndicator().wrapCenter();
            }
            if (state.status.isSubmissionSuccess) {
              var notes = state.notes;
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  var item = notes[index];
                  if (item is AddWrapperData<Note>) {
                    return NotificationItem(
                      item.item,
                      onClicked: (note) async {
                        var result = await AddNoteScreen.navigate(
                          context,
                          note: note,
                        );

                        if (result == true) {
                          cubit.fetchNotes();
                        }
                      },
                    );
                  }
                  return const CsBannerAd();
                },
                itemCount: notes.length,
                padding: const EdgeInsets.all(20),
                separatorBuilder: (ctx, index) => const Divider(),
              );
            }
            return const EmptyStateWidget();
          },
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem(
    this._note, {
    Key? key,
    required this.onClicked,
  }) : super(key: key);
  final Note _note;
  final Function(Note) onClicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: CustomColors.actionColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Text(
          _note.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).asButton(onTap: () => onClicked.call(_note)),
    );
  }
}
