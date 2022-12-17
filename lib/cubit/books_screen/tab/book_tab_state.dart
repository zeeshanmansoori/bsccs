part of 'book_tab_cubit.dart';

class BookTabState extends Equatable {
  final List<BookPageData> books;
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
    List<BookPageData>? books,
    bool? isLoading,
  }) {
    return BookTabState(
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
