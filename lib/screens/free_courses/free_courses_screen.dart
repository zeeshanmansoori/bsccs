import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class FreeCoursesScreen extends StatelessWidget {
  const FreeCoursesScreen({Key? key}) : super(key: key);
  static const routeName = "/free_courses";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.csAppBar(titleText: "Free Courses"),
    );
  }
}
