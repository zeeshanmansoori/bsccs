part of 'book_screen_cubit.dart';

class BooksScreenState extends Equatable {
  final int? semesters;
  final bool apiStatus;
  final String message;
  final int defaultSem;
  final List<BooksTabData> tabsData;
  final String? courseName;

  @override
  List<Object?> get props => [
        semesters,
        apiStatus,
        message,
        defaultSem,
        tabsData,
        courseName,
      ];

  const BooksScreenState({
    this.semesters,
    this.apiStatus = true,
    this.message = "",
    this.defaultSem = 2,
    this.tabsData = const [],
    this.courseName,
  });

  BooksScreenState copyWith({
    int? semesters,
    bool? apiStatus,
    String? message,
    int? defaultSem,
    List<BooksTabData>? tabsData,
    String? courseName,
  }) {
    return BooksScreenState(
      semesters: semesters ?? this.semesters,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      defaultSem: defaultSem ?? this.defaultSem,
      tabsData: tabsData ?? this.tabsData,
      courseName: courseName ?? this.courseName,
    );
  }
}
