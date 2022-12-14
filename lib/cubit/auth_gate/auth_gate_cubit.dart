import 'package:bloc/bloc.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_gate_state.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  final CsRepository _csRepository;

  AuthGateCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const AuthGateState());

  void init() {
    _csRepository.getCourseInfo().then((value) async {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;

      emit(state.copyWith(
        semesters: sem,
        apiStatus: false,
        courseName: courseName,
      ));
    });
  }

  void updateUserId() {
    _csRepository.setUserId(FirebaseAuth.instance.currentUser!.uid);
  }
}
