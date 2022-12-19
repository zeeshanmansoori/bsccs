part of 'book_screen_cubit.dart';

class BooksScreenState extends Equatable {
  final int? semesters;
  final bool apiStatus;
  final String message;
  final int defaultSem;
  final List<ListWrapper<CourseBook>> tabBooks;
  final String? courseName;
  final bool isBookLoading;

  @override
  List<Object?> get props => [
        semesters,
        apiStatus,
        message,
        defaultSem,
        tabBooks,
        courseName,
        isBookLoading,
      ];

  const BooksScreenState({
    this.semesters,
    this.apiStatus = true,
    this.message = "",
    this.defaultSem = 2,
    this.tabBooks = const [],
    this.courseName,
    this.isBookLoading = true,
  });

  BooksScreenState copyWith({
    int? semesters,
    bool? apiStatus,
    String? message,
    int? defaultSem,
    List<ListWrapper<CourseBook>>? tabBooks,
    String? courseName,
    bool? isBookLoading,
  }) {
    return BooksScreenState(
      semesters: semesters ?? this.semesters,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
      defaultSem: defaultSem ?? this.defaultSem,
      tabBooks: tabBooks ?? this.tabBooks,
      courseName: courseName ?? this.courseName,
      isBookLoading: isBookLoading ?? this.isBookLoading,
    );
  }
}
