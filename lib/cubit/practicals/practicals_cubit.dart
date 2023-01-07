import 'package:bloc/bloc.dart';
import 'package:bsccs/models/add_wrapper.dart';
import 'package:bsccs/models/list_wrapper.dart';
import 'package:collection/collection.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'practicals_state.dart';

class PracticalsCubit extends Cubit<PracticalsState> {
  final CsRepository _csRepository;
  final String courseName;
  final int semesterCount;

  PracticalsCubit(
    CsRepository csRepository, {
    required this.courseName,
    required this.semesterCount,
  })  : _csRepository = csRepository,
        super(const PracticalsState()) {
    _init();
  }

  void _init() async {
    Map<int, List<AddWrapper>> map = Map.of(state.tabsData);
    for (var i = 0; i < semesterCount; ++i) {
      _getTabsData(i + 1, courseName).then((practicals) {
        sortById(Practical a,Practical b) => a.practicalNumber.compareTo(b.practicalNumber);
        practicals.sort(sortById);

        var groupedData = groupBy(practicals, (s) => s.subjectId);
        List<ListWrapper<Practical>> wrapperList = groupedData
            .map(
              (key, value) => MapEntry(
                key,
                ListWrapper(
                  subjectId: key,
                  subjectName: value.first.subjectName,
                  items: value,
                ),
              ),
            )
            .values
            .toList();

        var list = wrapperList
            .map((e) => AddWrapperData(item: e) as AddWrapper)
            .toList();

        if (list.isNotEmpty) list.insert(0, AddWrapperAd());
        map[i] = list.toList();
        emit(state.copyWith(
          tabsData: Map.unmodifiable(map),
        ));
      });
    }
  }

  Future<List<Practical>> _getTabsData(int semester, String courseName) {
    return _csRepository.getPracticals(semester, courseName);
  }
}
