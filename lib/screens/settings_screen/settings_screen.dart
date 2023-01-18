import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Settings"),
      body: ListView(children: [

      ],),
    );
  }
}
