import 'package:cloud_firestore/cloud_firestore.dart';

class FreeCourse {
  final String courseLink;
  final String courseName;
  final String courseImage;
  final String courseDescription;
  final String courseFrom;
  final String courseProviderImage;
  final String courseStream;

  FreeCourse({
    required this.courseLink,
    required this.courseName,
    required this.courseImage,
    required this.courseDescription,
    required this.courseFrom,
    required this.courseProviderImage,
    required this.courseStream,
  });

  factory FreeCourse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var courseLink = json["courseLink"];
    var courseName = json["courseName"];
    var courseImage = json["courseImage"];
    var courseDescription = json["courseDescription"];
    var courseFrom = json["courseFrom"];
    var courseProviderImage = json["courseProviderImage"];
    var courseStream = json["courseStream"];

    return FreeCourse(
      courseLink: courseLink,
      courseName: courseName,
      courseImage: courseImage,
      courseDescription: courseDescription,
      courseFrom: courseFrom,
      courseProviderImage: courseProviderImage,
      courseStream: courseStream,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "courseLink": courseLink,
      "courseImage": courseImage,
      "courseName": courseName,
    };
  }
}
