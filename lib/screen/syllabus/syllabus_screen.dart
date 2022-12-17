import 'package:bsccs/cubit/syllabus_screen/syllabus_cubit.dart';
import 'package:bsccs/custom_widgets/ad_widget.dart';
import 'package:bsccs/screen/syllabus/widgets/syllabus_item_widget.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_repository/shared_repo.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  static const String routeName = "/SyllabusScreen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SyllabusCubit(context.read<CsRepository>()),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          titleSpacing: 0,
          title: const Text(
            'Syllabus',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<SyllabusCubit, SyllabusState>(
          builder: (context, state) {
            var isLoading = state.isLoading;
            var syllabus = state.syllabus;

            if (isLoading) {
              return const CircularProgressIndicator().wrapCenter();
            }
            return Column(
              children: [
                GridView.count(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  children:
                      syllabus.map((e) => mapBookPageDataToWidget(e)).toList(),
                ).expanded(flex: 3),
                const AdWidget().expanded(flex: 1)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget mapBookPageDataToWidget(dynamic syllabus) {
    if (syllabus is CourseSyllabus) {
      return SyllabusItemWidget(
        syllabus: syllabus,
        onClicked: () {},
      );
    }

    return const AdWidget();
  }
}
