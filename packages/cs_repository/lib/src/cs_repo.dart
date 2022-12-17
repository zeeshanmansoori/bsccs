import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_repository/shared_repo.dart';

class CsRepository {
  final _db = FirebaseFirestore.instance;
  final String _collectionInfoName = "info";
  final String _collectionBook = "books";
  final String _csInfoDoc = "computer_science";

  Future<CourseInfo?> getCourseInfo() async {
    var result = await _db
        .collection(_collectionInfoName)
        .doc(_csInfoDoc)
        .withConverter(
          fromFirestore: CourseInfo.fromFirestore,
          toFirestore: (CourseInfo info, _) => info.toFirestore(),
        )
        .get();
    return result.data();
  }

  Future<List<CourseBook>> getBooks(
    int semester,
    String courseName,
  ) async {
    log("zeehan $courseName _collectionBook $_collectionBook semester = sem$semester");
    var result = await _db
        .collection(courseName)
        .doc("sem$semester")
        .collection(_collectionBook)
        .withConverter(
          fromFirestore: CourseBook.fromFirestore,
          toFirestore: (CourseBook info, _) => info.toFirestore(),
        )
        .get();
    return result.docs.map((e) => e.data()).toList();
  }
}
