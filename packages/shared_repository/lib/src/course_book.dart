import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BookPageData {}

class GoogleAdd extends BookPageData {

}

class CourseBook extends BookPageData {
  final String link;
  final String imageLink;
  final String name;

  CourseBook({
    required this.link,
    required this.imageLink,
    required this.name,
  });

  factory CourseBook.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var link = json["link"];
    var imageLink = json["imageLink"];
    var name = json["name"];

    return CourseBook(
      link: link,
      imageLink: imageLink,
      name: name,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "link": link,
      "imageLink": imageLink,
      "name": name,
    };
  }
}
