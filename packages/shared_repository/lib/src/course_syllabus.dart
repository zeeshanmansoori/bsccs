import 'package:cloud_firestore/cloud_firestore.dart';

class CourseSyllabus {
  final String link;
  final String name;
  final String imageLink;

  CourseSyllabus({
    required this.link,
    required this.name,
    required this.imageLink,
  });

  factory CourseSyllabus.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var link = json["link"];
    var name = json["name"];
    var imageLink = json["imageLink"];

    return CourseSyllabus(
      link: link,
      name: name,
      imageLink: imageLink,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "link": link,
      "name": name,
      "imageLink": imageLink,
    };
  }
}
