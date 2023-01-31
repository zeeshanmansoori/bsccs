import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bsccs/use_case/auth_use_case.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

part 'auth_gate_state.dart';

class AuthGateCubit extends Cubit<AuthGateState> {
  final CsRepository _csRepository;
  late StreamSubscription<bool> internetSubscription;
  final AuthUseCase _authUseCase = AuthUseCase();

  AuthGateCubit(CsRepository csRepository)
      : _csRepository = csRepository,
        super(const AuthGateState()) {
    _init();
  }

  void _init() {
    internetSubscription =
        InternetConnectivity().observeInternetConnection.listen((hasInternet) {
      _csRepository.updateFetchFrom(hasInternet);
      emit(state.copyWith(
        hasInternet: hasInternet,
        previouslyHasInternet: state.hasInternet,
      ));
    });
  }

  void login() async {
    if (state.status.isSubmissionInProgress) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _authUseCase.signInWithGoogle().then(
      (value) {
        var user = value.user;
        var name = user?.displayName ?? "";
        var image = user?.photoURL ?? "";
        var email = user?.email ?? "";
        var userId = user?.uid ?? "";

        _csRepository.saveUserInfo(
          userId,
          name,
          image,
          email,
        );

        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
        ));
        fetchCourseDetails();
      },
      onError: (error, stackTrace) {
        emit(state.copyWith(
          message: error.toString(),
          status: FormzStatus.submissionFailure,
        ));
      },
    );
  }

  void fetchCourseDetails() {
    _csRepository.getCourseInfo().then((value) async {
      if (value == null) return;

      var sem = value.semesters;
      var courseName = value.courseName;
      emit(state.copyWith(
        semesters: sem,
        status: FormzStatus.submissionSuccess,
        courseName: courseName,
      ));
    });
    //     .onError((error, stackTrace) {
    //   print("zeeshan stackTrace $stackTrace");
    // });
  }

  void updateUserId() {
    _csRepository.setUserId(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Future<void> close() {
    internetSubscription.cancel();
    return super.close();
  }

  void clearMessage() {
    emit(state.copyWith(message: ""));
  }

  void logOut() {
    _csRepository.clearSharedPref();
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  int getDefaultSem() {
    return _csRepository.defaultSem ?? 1;
  }
}
