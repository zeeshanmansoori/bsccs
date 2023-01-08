import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/screens/auth/auth_screen.dart';
import 'package:bsccs/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const AuthScreen();
        }
        var cubit = context.read<AuthGateCubit>();
        cubit.updateUserId();
        return const HomeScreen();
      },
    );
  }
}
