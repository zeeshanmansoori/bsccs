import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/cubit/home/home_cubit.dart';
import 'package:bsccs/models/global_arguments.dart';
import 'package:bsccs/screens/home/widgets/home_action_widget.dart';
import 'package:bsccs/screens/home/widgets/home_recent_widget.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recent = [];
    // [
    //   const HomeRecent(
    //       title: "Concert Mathematics 3rd Edition by mac leran special disc",
    //       description: "By James Bond"),
    //   const HomeRecent(
    //       title: "Concert Mathematics", description: "By James Bond"),
    //   const HomeRecent(
    //       title: "Concert Mathematics", description: "By James Bond"),
    //   const HomeRecent(
    //       title: "Concert Mathematics", description: "By James Bond"),
    // ];

    return BlocProvider(
      create: (context) => HomeCubit(context.read<CsRepository>()),
      child: Builder(builder: (context) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBar(
            title: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Text(
                  "Hi 👋, ${state.userInfo?.userName}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                );
              },
            ),
            titleSpacing: 0,
            backgroundColor: Colors.white,
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                splashRadius: Constants.splashRadius,
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                ),
              ),
              IconButton(
                splashRadius: Constants.splashRadius,
                onPressed: () {},
                icon: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    var image = state.userInfo?.image ?? "";
                    return CircleAvatar(
                      backgroundImage:
                          image.isEmpty ? null : NetworkImage(image),
                    );
                  },
                ),
              ).paddingForOnly(right: 10)
            ],
          ),
          body: Column(
            children: [
              GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: cubit.homeActions
                    .map(
                      (action) => HomeActionWidget(
                        homeAction: action,
                        onClicked: () => Navigator.pushNamed(
                          context,
                          action.destinationName,
                          arguments: GlobalArguments(
                            courseName:
                                context.read<AuthGateCubit>().state.courseName!,
                            semesterCount:
                                context.read<AuthGateCubit>().state.semesters!,
                            defaultSemester:
                                context.read<AuthGateCubit>().state.defaultSem,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ).paddingWithSymmetry(vertical: 30, horizontal: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recently viewed",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "View All",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ).paddingWithSymmetry(horizontal: 20),
              if (recent.isEmpty)
                const Text("No recent found")
                    .wrapCenter()
                    .paddingForOnly(top: 100),
              if (recent.isNotEmpty)
                ListView(
                  children: recent
                      .map((e) => HomeRecentWidget(homeRecent: e)
                          .paddingWithSymmetry(horizontal: 15))
                      .toList(),
                ).expanded(flex: 1)
            ],
          ),
          drawer: Drawer(
            width: MediaQuery.of(context).size.width * .6,
            child: Container(
              color: Colors.blue,
            ),
          ),
        );
      }),
    );
  }
}
