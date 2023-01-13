import 'package:bloc/bloc.dart';
import 'package:cs_repository/src/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:shared_repository/shared_repo.dart';

part 'free_courses_state.dart';

class FreeCoursesCubit extends Cubit<FreeCoursesState> {
  final CsRepository _csRepository;

  FreeCoursesCubit(this._csRepository) : super(const FreeCoursesState()) {
    _fetchCourses();
  }

  _fetchCourses() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var result = await _csRepository.getFreeCourses();
      emit(state.copyWith(
        courses: result,
        status: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          msg: e.toString(),
        ),
      );
    }
  }
}
