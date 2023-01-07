import 'package:cloud_firestore/cloud_firestore.dart';

class Practical {

  final String subjectName;
  final String subjectId;
  final String link;
  final int practicalNumber;

  const Practical({
    required this.subjectName,
    required this.subjectId,
    required this.practicalNumber,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return {
      'subjectName': subjectName,
      'subjectId': subjectId,
      'practicalNumber': practicalNumber,
      'link': link,
    };
  }


  factory Practical.fromMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final map = snapshot.data()!;
    return Practical(
      subjectName: map['subjectName'] as String,
      subjectId: map['subjectId'] as String,
      practicalNumber: int.tryParse(map['practicalNumber'])??0,
      link: map['link'] as String,
    );
  }
}
