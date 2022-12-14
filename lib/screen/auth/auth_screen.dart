import 'package:bsccs/screen/auth/cubit/auth_screen_cubit.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthScreenCubit(),
      child: Builder(builder: (context) {
        var cubit = context.read<AuthScreenCubit>();
        return Scaffold(
          body: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: cubit.login,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(MdiIcons.google),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Signin with google",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ).paddingWithSymmetry(vertical: 10, horizontal: 20),
              ),
              Spacer(),
            ],
          ).withCenterProgressBar<AuthScreenCubit, AuthScreenState>(
                (prev, next) => prev.progressBarVisible != next.progressBarVisible,
                (state) => state.progressBarVisible,
          ),
        );
      }),
    );
  }
}
