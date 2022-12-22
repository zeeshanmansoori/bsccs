part of 'book_screen_cubit.dart';

class BooksScreenState extends Equatable {

  final String message;
  final Map<int, List<AddWrapper>> tabsData;

  @override
  List<Object?> get props => [
        message,
        tabsData,
      ];

  const BooksScreenState({
    this.message = "",
    this.tabsData = const {},
  });

  BooksScreenState copyWith({
    String? message,
    Map<int, List<AddWrapper>>? tabsData,
  }) {
    return BooksScreenState(
      message: message ?? this.message,
      tabsData: tabsData ?? this.tabsData,
    );
  }
}
