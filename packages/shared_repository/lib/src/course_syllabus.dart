import 'package:cloud_firestore/cloud_firestore.dart';

class CourseSyllabus {
  final String link;
  final String name;

  CourseSyllabus({
    required this.link,
    required this.name,
  });

  factory CourseSyllabus.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var link = json["link"];
    var name = json["name"];

    return CourseSyllabus(
      link: link,
      name: name,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "link": link,
      "name": name,
    };
  }
}
