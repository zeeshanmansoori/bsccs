part of 'books_screen_cubit.dart';

class BooksScreenState extends Equatable {
  final int? semesters;
  final bool apiStatus;
  final String message;

  @override
  List<Object?> get props => [
        semesters,
        apiStatus,
        message,
      ];

  const BooksScreenState({
    this.semesters,
    this.apiStatus = true,
    this.message = "",
  });

  BooksScreenState copyWith({
    int? semesters,
    bool? apiStatus,
    String? message,
  }) {
    return BooksScreenState(
      semesters: semesters ?? this.semesters,
      apiStatus: apiStatus ?? this.apiStatus,
      message: message ?? this.message,
    );
  }
}
