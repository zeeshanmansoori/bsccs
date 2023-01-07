import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/screens/add_note/add_note_screen.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Notes"),
      body: const EmptyStateWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>AddNoteScreen.navigate(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
