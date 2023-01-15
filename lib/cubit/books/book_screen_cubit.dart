import 'package:bloc/bloc.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'book_screen_state.dart';

class BooksScreenCubit extends Cubit<BooksScreenState> {
  final CsRepository _csRepository;
  final String courseName;
  final int semesterCount;

  BooksScreenCubit(
    CsRepository csRepository, {
    required this.courseName,
    required this.semesterCount,
  })  : _csRepository = csRepository,
        super(const BooksScreenState()) {
    _init();
  }

  void _init() {
    Map<int, List<AddWrapper>> map = Map.from(state.tabsData);
    for (var i = 0; i < semesterCount; ++i) {
      _getTabsData(i + 1, courseName).then((books) {
        if (isClosed) return;
        List<AddWrapper> list =
            books.map((e) => AddWrapperData(item: e) as AddWrapper).toList();
        if (list.isNotEmpty) list.insert(0, AddWrapperAd());
        map[i] = list.toList();
        emit(state.copyWith(
          tabsData: map,
        ));
      });
    }
  }

  Future<List<CourseBook>> _getTabsData(
    int semester,
    String courseName,
  ) async {
    return await _csRepository.getBooks(
      semester,
      courseName,
    );
  }
}
