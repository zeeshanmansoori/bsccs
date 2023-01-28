import 'package:bsccs/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  final void Function(B) onPressed;
  final bool Function(S) isEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        var cubit = context.read<B>();
        return MaterialButton(
          onPressed: isEnabled.call(state)?(){onPressed.call(cubit);}:null,
          color: CustomColors.primaryColor,
          textColor: Colors.white,
          disabledColor: CustomColors.primaryColor.shade100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const Text("Save"),
        );
      },
    );
  }
}
