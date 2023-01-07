import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);
  static const routeName = "/add_note";

  @override
  Widget build(BuildContext context) {
    QuillController _controller = QuillController.basic();
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Add Note"),
      body: Column(
        children: [
          Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              readOnly: false,
            ),
          ),
          QuillToolbar.basic(
            controller: _controller,
            toolbarSectionSpacing: 0,
            multiRowsDisplay: false,
          )
        ],
      ).paddingForAll(20),
    );
  }

  static navigate(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }
}
