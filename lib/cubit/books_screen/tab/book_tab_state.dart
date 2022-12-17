part of 'book_tab_cubit.dart';

class BookTabState extends Equatable {
  final List<dynamic> books;
  final bool isLoading;

  @override
  List<Object?> get props => [
        books,
        isLoading,
      ];

  const BookTabState({
    this.books = const [],
    this.isLoading = true,
  });

  BookTabState copyWith({
    List<dynamic>? books,
    bool? isLoading,
  }) {
    return BookTabState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
