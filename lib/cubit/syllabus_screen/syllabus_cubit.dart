import 'package:bloc/bloc.dart';
import 'package:bsccs/models/google_add.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_repository/shared_repo.dart';

part 'syllabus_state.dart';

class SyllabusCubit extends Cubit<SyllabusState> {
  final CsRepository _csRepository;
  final String _courseName;

  SyllabusCubit(CsRepository csRepository,String courseName)
      : _csRepository = csRepository,
        _courseName = courseName,
        super(const SyllabusState()) {
    _fetchSyllabus();
  }

  void _fetchSyllabus() async {
    var result = await _csRepository.getSyllabus(_courseName);
    List<CourseSyllabus> ls =  [];
    ls.addAll(result);
    emit(state.copyWith(
      syllabus: ls,
      isLoading: false,
    ));
  }
}
