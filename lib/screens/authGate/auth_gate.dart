import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/screens/auth/auth_screen.dart';
import 'package:bsccs/screens/home/home_screen.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthGateCubit, AuthGateState>(
      listener: (context, state) {
        var internetConnection = state.hasInternet;
        var previouslyHasInternet = state.previouslyHasInternet;
        if (internetConnection != null) {
          if (!internetConnection) {
            WidgetUtils.showSnackBar(context, "No internet connection");
          }
          if (internetConnection &&
              previouslyHasInternet != null &&
              !previouslyHasInternet) {
            WidgetUtils.showSnackBar(context, "Got back internet connection");
          }
        }
      },
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const AuthScreen();
          }
          var cubit = context.read<AuthGateCubit>();
          cubit.fetchCourseDetails();
          cubit.updateUserId();
          return const HomeScreen();
        },
      ),
    );
  }
}
