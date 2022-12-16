import 'package:bsccs/models/home_action.dart';
import 'package:bsccs/models/home_recent.dart';
import 'package:bsccs/screen/books/books_screen.dart';
import 'package:bsccs/screen/home/widgets/home_action_widget.dart';
import 'package:bsccs/screen/home/widgets/home_recent_widget.dart';
import 'package:bsccs/utils/bsc_cs_app_icons.dart';
import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeActions = [
      const HomeAction(
        iconData: BscCsApp.books,
        title: "Books",
        destinationName: BooksScreen.routeName,
      ),
      const HomeAction(
        iconData: BscCsApp.syllabus,
        title: "Syllabus",
        destinationName: BooksScreen.routeName,
      ),
      const HomeAction(
        iconData: BscCsApp.questions,
        title: "Questions",
        destinationName: BooksScreen.routeName,
      ),
      const HomeAction(
        iconData: BscCsApp.notes,
        title: "Notes",
        destinationName: BooksScreen.routeName,
      ),
      const HomeAction(
        iconData: BscCsApp.practicals,
        title: "Practicals",
        destinationName: BooksScreen.routeName,
      ),
      const HomeAction(
        iconData: BscCsApp.freeCourses,
        title: "Free Courses",
        destinationName: BooksScreen.routeName,
      ),
    ];

    var recent = [
      const HomeRecent(
          title: "Concert Mathematics 3rd Edition by mac leran special disc",
          description: "By James Bond"),
      const HomeRecent(
          title: "Concert Mathematics", description: "By James Bond"),
      const HomeRecent(
          title: "Concert Mathematics", description: "By James Bond"),
      const HomeRecent(
          title: "Concert Mathematics", description: "By James Bond"),
    ];

    var userName = "Zeeshan";
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              icon: CircleAvatar(
                backgroundColor: Colors.indigo,
              )).paddingForOnly(right: 10)
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "Hi 👋, $userName",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ).paddingForOnly(left: 20, top: 5),
          GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: homeActions
                .map(
                  (action) => HomeActionWidget(
                    homeAction: action,
                    onClicked: () => Navigator.pushNamed(
                      context,
                      action.destinationName,
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
          ...recent
              .map((e) => HomeRecentWidget(homeRecent: e)
                  .paddingWithSymmetry(horizontal: 15))
              .toList()
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * .6,
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
