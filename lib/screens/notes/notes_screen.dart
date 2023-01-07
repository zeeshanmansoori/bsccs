import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Notes"),
    );
  }
}
