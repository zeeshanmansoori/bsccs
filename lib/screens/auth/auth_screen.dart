import 'package:bsccs/cubit/auth/auth_screen_cubit.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/utils.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthScreenCubit(context.read<CsRepository>()),
      child: Builder(builder: (context) {
        var cubit = context.read<AuthScreenCubit>();
        return Scaffold(
          body: BlocListener<AuthScreenCubit, AuthScreenState>(
            listener: (context, state) {
              if (state.errorMsg.isNotEmpty) {
                var cubit = context.read<AuthScreenCubit>();
                cubit.clearMsg();
                WidgetUtils.showSnackBar(
                  context,
                  state.errorMsg,
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
          ).withCenterProgressBar<AuthScreenCubit, AuthScreenState>(
            (prev, next) => prev.progressBarVisible != next.progressBarVisible,
            (state) => state.progressBarVisible,
          ),
        );
      }),
    );
  }
}
