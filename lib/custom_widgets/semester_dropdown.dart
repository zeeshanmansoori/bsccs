import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SemesterDropDown<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  const SemesterDropDown({
    Key? key,
    required this.onChanged,
    required this.getSemCount,
    required this.getSelectedValue,
    this.dropdownMaxHeight,
    this.underLine = true,
  }) : super(key: key);
  final int? Function(S) getSelectedValue;
  final int getSemCount;
  final void Function(B, int?) onChanged;
  final double? dropdownMaxHeight;
  final bool underLine;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        var cubit = context.read<B>();
        return DropdownButton2<int>(
          value: getSelectedValue.call(state),
          items: List.generate(
            getSemCount,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text(
                "Semester ${index + 1}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          onChanged: (value) => onChanged.call(cubit, value),
          isExpanded: true,
          hint: const Text(
            "Choose semester",
          ).paddingForOnly(left: 10),
          dropdownMaxHeight: dropdownMaxHeight,
          buttonPadding: const EdgeInsets.all(5),
          icon: const Icon(Icons.arrow_drop_down).paddingForOnly(right: 20),
          underline: underLine ? null :const SizedBox.shrink(),
        );
      },
    );
  }
}
