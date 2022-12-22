import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaper {
  final String image;
  final String subjectName;
  final String subjectId;
  final String timeStamp;
  final String link;

  const QuestionPaper({
    required this.image,
    required this.subjectName,
    required this.subjectId,
    required this.timeStamp,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'subjectName': subjectName,
      'subjectId': subjectId,
      'timeStamp': timeStamp,
      'link': link,
    };
  }


  factory QuestionPaper.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return QuestionPaper(
      image: map['image'] as String,
      subjectName: map['subjectName'] as String,
      subjectId: map['subjectId'] as String,
      timeStamp: map['timeStamp'] as String,
      link: map['link'] as String,
    );
  }
}
