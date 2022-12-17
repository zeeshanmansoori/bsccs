import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_repository/shared_repo.dart';

class CourseInfo {
  final int semesters;
  final String courseName;
  final List<CourseSyllabus> syllabus;

  const CourseInfo({
    required this.semesters,
    required this.courseName,
    required this.syllabus,
  });

  factory CourseInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var semesters = json["semesters"];
    var courseName = json["courseName"];
    var syllabus = Map.from(json["syllabus"])
        .map(
          (key, value) => MapEntry(
            key,
            CourseSyllabus(
              link: value,
              name: key,
            ),
          ),
        )
        .values
        .toList();

    return CourseInfo(
      semesters: semesters,
      courseName: courseName,
      syllabus: syllabus,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "semesters": semesters,
      "courseName": courseName,
    };
  }
}
