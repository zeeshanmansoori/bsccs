import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String data;
  final String id;
  final String title;

  Note({
    required this.id,
    required this.title,
    required this.data,
  });

  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var data = json["data"];
    var id = json["id"];
    var title = json["title"];

    return Note(
      id: id,
      title: title,
      data: data,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "data": data,
    };
  }
}
