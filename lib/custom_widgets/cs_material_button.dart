import 'package:bsccs/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CsMaterialButton<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  const CsMaterialButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
    this.buttonColor = CustomColors.primaryColor,
    this.disabledColor = CustomColors.buttonDisabledColor,
    this.buttonRadius = 5,
    this.textColor = Colors.white,
    this.child,
    this.text,
  }) : super(key: key);

  final void Function(B) onPressed;
  final bool Function(S) isEnabled;
  final Color buttonColor;
  final Color disabledColor;
  final Color textColor;
  final String? text;
  final Widget? child;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    assert(text != null || child != null, "pass either text string or child");
    return BlocBuilder<B, S>(
      builder: (context, state) {
        var cubit = context.read<B>();
        return MaterialButton(
          onPressed: isEnabled.call(state)
              ? () {
                  onPressed.call(cubit);
                }
              : null,
          color: buttonColor,
          textColor: textColor,
          disabledColor: disabledColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(buttonRadius),
            ),
          ),
          child: child ??
              Text(
                text!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
        );
      },
    );
  }
}
