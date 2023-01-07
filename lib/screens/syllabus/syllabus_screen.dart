import 'package:bsccs/cubit/syllabus_screen/syllabus_cubit.dart';
import 'package:bsccs/custom_widgets/ad_widget.dart';
import 'package:bsccs/custom_widgets/tab_item_widget.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({Key? key}) : super(key: key);

  static const String routeName = "/SyllabusScreen";

  @override
  Widget build(BuildContext context) {
    var homeArgument =
        ModalRoute.of(context)?.settings.arguments as GlobalArguments;
    var courseName = homeArgument.courseName;

    return BlocProvider(
      create: (context) =>
          SyllabusCubit(context.read<CsRepository>(), courseName),
      child: Scaffold(
        appBar: WidgetUtils.csAppBar(titleText: "Syllabus"),
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
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  children: syllabus
                      .map((e) => TabItemWidget(
                            title: e.name,
                            imageLink: e.imageLink,
                            onClicked: () {},
                          ))
                      .toList(),
                ).expanded(flex: 3),
                const AdWidget()
                    .paddingForOnly(bottom: 10, left: 10, right: 10)
                    .expanded(flex: 1)
              ],
            );
          },
        ),
      ),
    );
  }
}
