import 'package:bsccs/cubit/auth_gate/auth_gate_cubit.dart';
import 'package:bsccs/custom_widgets/cs_material_button.dart';
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
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
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
          children: [
            const Spacer(),
            Lottie.asset(
              Utils.getLottiePath("books"),
              fit: BoxFit.fitWidth,
            ),
            const Spacer(
              flex: 2,
            ),
            CsMaterialButton<AuthGateCubit, AuthGateState>(
              buttonColor: Colors.white,
              buttonRadius: 15,
              isEnabled: (state) {
                return true;
              },
              onPressed: (cubit) {
                cubit.login();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Utils.getImagePath("google"),
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Sign in with google",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ).paddingWithSymmetry(vertical: 16),
              ),
            ).paddingWithSymmetry(horizontal: 30),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ).withCenterProgressBar<AuthGateCubit, AuthGateState>(
        (prev, next) => prev.status != next.status,
        (state) => state.status.isSubmissionInProgress,
      ),
    );
  }
}
