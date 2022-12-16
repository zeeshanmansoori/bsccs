import 'package:cloud_firestore/cloud_firestore.dart';

class CourseInfo {
  final int semesters;
  final String courseName;

  const CourseInfo({
    required this.semesters,
    required this.courseName,
  });

  factory CourseInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var semesters = json["semesters"];
    var courseName = json["courseName"];

    return CourseInfo(
      semesters: semesters,
      courseName: courseName,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "semesters": semesters,
      "courseName": courseName,
    };
  }
}
