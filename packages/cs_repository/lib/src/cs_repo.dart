import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_shared_preferences/cs_shared_preferences.dart';
import 'package:shared_repository/shared_repo.dart';

class CsRepository {
  final _db = FirebaseFirestore.instance;
  final String _collectionInfoName = "info";
  final String _collectionBook = "books";
  final String _collectionQuestionPapers = "question_papers";
  final String _collectionPracticals = "practicals";
  final String _csInfoDoc = "computer_science";
  final String _userCollection = "users";
  final String _syllabusDocName = "syllabus";
  final defaultOption = const GetOptions(source: Source.serverAndCache);
  GetOptions _getOptions = const GetOptions(source: Source.serverAndCache);
  int? defaultSem;
  String? _userId;

  String get userId => _userId!;

  CsRepository() {
    _init();
  }

  void _init() async {
    defaultSem = await CsSharedPreferences.getMySem();
  }

  void saveUserInfo(
    String userId,
    String name,
    String image,
    String email, {
    int mySemester = -1,
  }) {
    var userInfo = UserDetails(
      userId: userId,
      userName: name,
      image: image,
      email: email,
      mySemester: mySemester,
    );
    CsSharedPreferences.setUserInfo(userInfo);
    _db.collection(_userCollection).doc(userId).set(userInfo.toFireStore());
  }

  Future<UserDetails> getUserInfo() {
    return CsSharedPreferences.getUserInfo();
  }

  Future<CourseInfo?> getCourseInfo() async {
    var result = await _db
        .collection(_collectionInfoName)
        .doc(_csInfoDoc)
        .withConverter(
          fromFirestore: CourseInfo.fromFirestore,
          toFirestore: (CourseInfo info, _) => info.toFirestore(),
        )
        .get(_getOptions);
    return result.data();
  }

  Future<List<CourseBook>> getBooks(
    int semester,
    String courseName,
  ) async {
    var result = await _db
        .collection(courseName)
        .doc("sem$semester")
        .collection(_collectionBook)
        .withConverter(
          fromFirestore: CourseBook.fromFirestore,
          toFirestore: (CourseBook info, _) => info.toFirestore(),
        )
        .get(_getOptions);
    return result.docs.map((e) => e.data()).toList();
  }

  Future<List<QuestionPaper>> getQuestionPapers(
    int semester,
    String courseName,
  ) async {
    var result = await _db
        .collection(courseName)
        .doc("sem$semester")
        .collection(_collectionQuestionPapers)
        .withConverter(
          fromFirestore: QuestionPaper.fromMap,
          toFirestore: (QuestionPaper info, _) => info.toMap(),
        )
        .get(_getOptions);
    return result.docs.map((e) => e.data()).toList();
  }

  Future<List<Practical>> getPracticals(
    int semester,
    String courseName,
  ) async {
    var result = await _db
        .collection(courseName)
        .doc("sem$semester")
        .collection(_collectionPracticals)
        .withConverter(
          fromFirestore: Practical.fromMap,
          toFirestore: (Practical info, _) => info.toMap(),
        )
        .get(_getOptions);
    return result.docs.map((e) => e.data()).toList();
  }

  Future<List<CourseSyllabus>> getSyllabus(
    String courseName,
  ) async {
    var result = await _db
        .collection(courseName)
        .doc(_syllabusDocName)
        .collection(_syllabusDocName)
        .withConverter(
          fromFirestore: CourseSyllabus.fromFirestore,
          toFirestore: (CourseSyllabus info, _) => info.toFirestore(),
        )
        .get(_getOptions);
    return result.docs.map((e) => e.data()).toList();
  }

  Future<void> saveNotes(
    String title,
    String jsonEncode, {
    required noteId,
  }) {
    var document =
        _db.collection("users").doc(userId).collection("notes").doc();
    return document.set({
      "id": noteId ?? document.id,
      "title": title,
      "data": jsonEncode,
    });
  }

  Future<List<Note>> getNotes() async {
    var documents = await _db
        .collection("users")
        .doc(userId)
        .collection("notes")
        .withConverter(
          fromFirestore: Note.fromFirestore,
          toFirestore: (Note note, _) => note.toFirestore(),
        )
        .get(_getOptions);

    return documents.docs.map((e) => e.data()).toList();
  }

  Future<List<FreeCourse>> getFreeCourses() async {
    var documents = await _db
        .collection("free_courses")
        .withConverter(
          fromFirestore: FreeCourse.fromFirestore,
          toFirestore: (FreeCourse course, _) => course.toFirestore(),
        )
        .get(_getOptions);
    return documents.docs.map((e) => e.data()).toList();
  }

  void setUserId(String uid) {
    _userId = uid;
  }

  String getPdfLink(String id) {
    return "https://drive.google.com/u/0/uc?id=$id&export=download";
  }

  void updateFetchFrom(bool hasInternet) async {
    var offlineModeEnabled = await getOfflineMode();
    _getOptions = (offlineModeEnabled && !hasInternet)
        ? const GetOptions(source: Source.cache)
        : defaultOption;
  }

  void saveSelectedSemester(int sem) {
    defaultSem = sem;
    CsSharedPreferences.saveMySem(sem);
  }

  Future<int?> getDefaultSemester() async {
    defaultSem = await CsSharedPreferences.getMySem();
    return defaultSem;
  }

  void setOfflineMode(bool value) {
    CsSharedPreferences.setOfflineMode(value);
  }

  Future<bool> getOfflineMode() {
    return CsSharedPreferences.getOfflineMode();
  }

  void clearSharedPref() {
    CsSharedPreferences.clear();
  }
}
