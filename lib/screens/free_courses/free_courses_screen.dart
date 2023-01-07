import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/screens/free_courses/widgets/course_item_widget.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class FreeCoursesScreen extends StatelessWidget {
  const FreeCoursesScreen({Key? key}) : super(key: key);
  static const routeName = "/free_courses";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetUtils.csAppBar(titleText: "Free Courses"),
        body: ListView.builder(
          itemBuilder: (ctx, index) => CourseItemWidget(),
          itemCount: 10,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        ));
  }
}
