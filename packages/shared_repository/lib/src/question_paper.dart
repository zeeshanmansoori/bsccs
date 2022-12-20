import 'package:cloud_firestore/cloud_firestore.dart';

class BookQuestions {
  final List<QuestionPaper> links;
  final String subjectName;

  BookQuestions({
    required this.links,
    required this.subjectName,
  });

  factory BookQuestions.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data()!;
    var links = List.from(json["links"]).map((e) => QuestionPaper.fromJson(e)).toList();
    var name = json["name"];

    return BookQuestions(
      links: links,
      subjectName: name,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "links": links,
      "name": subjectName,
    };
  }
}

class QuestionPaper {
  final String link;
  final String timeStamp;

  const QuestionPaper({
    required this.link,
    required this.timeStamp,
  });

  factory QuestionPaper.fromJson(Map<dynamic, dynamic> json) {
    var link = json["link"];
    var timeStamp = json["time_stamp"];
    return QuestionPaper(link: link, timeStamp: timeStamp);
  }
}
