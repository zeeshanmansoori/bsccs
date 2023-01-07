import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class PracticalsScreen extends StatelessWidget {
  const PracticalsScreen({Key? key}) : super(key: key);
  static const routeName = "/practicals";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Practicals"),
    );
  }
}
