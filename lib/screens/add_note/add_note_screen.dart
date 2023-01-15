import 'dart:convert';

import 'package:bsccs/cubit/add_note/add_note_cubit.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/extension/extension.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:formz/formz.dart';
import 'package:shared_repository/shared_repo.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = "/add_note";

  @override
  Widget build(BuildContext context) {
    final node = FocusNode();

    final oldNote = ModalRoute.of(context)?.settings.arguments?.tryCast<Note>();
    Document document = oldNote == null
        ? Document.fromJson([
            {
              "insert": "Title: ",
              "attributes": {"bold": true}
            },
            {
              "insert": "\n",
              "attributes": {"bold": true, "header": 1}
            }
          ])
        : Document.fromJson(jsonDecode(oldNote.data));
    var offset = oldNote == null ? 7 : 0;
    QuillController controller = QuillController(
      document: document,
      selection: TextSelection.collapsed(offset: offset),
    );
    node.requestFocus();
    return BlocProvider(
      create: (context) => AddNoteCubit(context.read<CsRepository>()),
      child: BlocListener<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state.msg.isEmpty) {
            WidgetUtils.showSnackBar(context, state.msg);
          }

          if (state.status.isSubmissionSuccess) {
            Navigator.of(context).pop(true);
          }
        },
        child: BlocListener<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            if (state.msg.isNotEmpty) {
              WidgetUtils.showSnackBar(context, state.msg);
              context.read<AddNoteCubit>().updateMsg("");
            }
          },
          child: Builder(builder: (context) {
            var cubit = context.read<AddNoteCubit>();
            return Scaffold(
                appBar: WidgetUtils.csAppBar(titleText: "Add Note", actions: [
                  BlocBuilder<AddNoteCubit, AddNoteState>(
                    buildWhen: (p, c) => p.status != c.status,
                    builder: (context, state) {
                      if (state.status.isSubmissionInProgress) {
                        return Row(
                          children: const [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ).paddingForOnly(right: 10);
                      }
                      return WidgetUtils.saveButton(() {
                        cubit.saveNote(
                          jsonEncode(controller.document.toDelta().toJson()),
                          controller.document.toPlainText(),
                          noteId: oldNote?.id,
                        );
                      });
                    },
                  ),
                ]),
                body: Column(
                  children: [
                    Expanded(
                      child: QuillEditor(
                        controller: controller,
                        readOnly: false,
                        padding: const EdgeInsets.all(20),
                        focusNode: node,
                        autoFocus: true,
                        scrollController: ScrollController(),
                        scrollable: true,
                        expands: true,
                      ),
                    ),
                    QuillToolbar.basic(
                      controller: controller,
                      toolbarSectionSpacing: 0,
                      multiRowsDisplay: false,
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }

  static Future<T?> navigate<T>(BuildContext context, {Note? note}) {
    return Navigator.pushNamed<T?>(
      context,
      routeName,
      arguments: note,
    );
  }
}
