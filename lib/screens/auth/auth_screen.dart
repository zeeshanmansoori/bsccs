import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/utils.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthGateCubit>();
    return Scaffold(
      body: BlocListener<AuthGateCubit, AuthGateState>(
        listener: (context, state) {
          if (state.message.isNotEmpty) {
            cubit.clearMessage();
            WidgetUtils.showSnackBar(
              context,
              state.message,
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Lottie.asset(Utils.getLottiePath("education")),
            ).expanded(flex: 3),
            MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: cubit.login,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Utils.getImagePath("google"),
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Sign in with google",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: .8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ).paddingWithSymmetry(vertical: 12),
            ),
            const Spacer(),
          ],
        ),
      ).withCenterProgressBar<AuthGateCubit, AuthGateState>(
        (prev, next) => prev.status != next.status,
        (state) => state.status.isSubmissionInProgress,
      ),
    );
  }
}
