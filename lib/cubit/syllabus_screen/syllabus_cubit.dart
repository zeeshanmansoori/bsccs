import 'package:bloc/bloc.dart';
import 'package:bsccs/models/google_add.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';

part 'syllabus_state.dart';

class SyllabusCubit extends Cubit<SyllabusState> {
  final CsRepository _csRepository;

  SyllabusCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const SyllabusState()) {
    _fetchSyllabus();
  }

  void _fetchSyllabus() async {
    var result = await _csRepository.getCourseInfo();
    List<dynamic> ls =  [];
    ls.addAll(result?.syllabus??[]);
    ls.add(GoogleAdd());
    emit(state.copyWith(
      syllabus: ls,
      isLoading: false,
    ));
  }
}
