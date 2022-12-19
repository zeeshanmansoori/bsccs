import 'package:cloud_firestore/cloud_firestore.dart';


class QuestionPaper {
  final String link;
  final String timeStamp;
  final String name;

  QuestionPaper({
    required this.link,
    required this.timeStamp,
    required this.name,
  });

  factory QuestionPaper.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var link = json["link"];
    var name = json["name"];
    var timeStamp = json["time_stamp"];

    return QuestionPaper(
      link: link,
      timeStamp: timeStamp,
      name: name,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "link": link,
      "time_stamp": timeStamp,
      "name": name,
    };
  }
}
