import 'package:bsccs/cubit/free_courses/free_courses_cubit.dart';
import 'package:bsccs/custom_widgets/empty_state_widget.dart';
import 'package:bsccs/screens/free_courses/widgets/course_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FreeCoursesScreen extends StatelessWidget {
  const FreeCoursesScreen({Key? key}) : super(key: key);
  static const routeName = "/free_courses";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FreeCoursesCubit(context.read<CsRepository>()),
      child: Scaffold(
          appBar: WidgetUtils.csAppBar(titleText: "Free Courses"),
          body: BlocBuilder<FreeCoursesCubit, FreeCoursesState>(
            builder: (context, state) {
              var items = state.courses;

              if (state.status.isSubmissionInProgress) {
                return const CircularProgressIndicator().wrapCenter();
              }
              if (items.isEmpty) {
                return const EmptyStateWidget();
              }

              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, index) => CourseItemWidget(items[index]),
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 10,
                ),
              );
            },
          )),
    );
  }
}
