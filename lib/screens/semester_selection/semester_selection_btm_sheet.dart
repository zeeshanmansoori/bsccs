import 'package:bsccs/cubit/home/home_cubit.dart';
import 'package:bsccs/cubit/semester_selection/semester_selection_cubit.dart';
import 'package:bsccs/custom_widgets/cs_material_button.dart';
import 'package:bsccs/custom_widgets/semester_dropdown.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SemesterSelectionBtmSheet extends StatelessWidget {
  const SemesterSelectionBtmSheet(this._homeCubit, {Key? key})
      : super(key: key);
  final HomeCubit _homeCubit;

  static show(BuildContext context, HomeCubit homeCubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SemesterSelectionBtmSheet(homeCubit),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(15),
          right: Radius.circular(15),
        ),
      ),
      isDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SemesterSelectionCubit(context.read<CsRepository>()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Select Your Semester",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ).paddingForOnly(top: 16),
          BlocBuilder<SemesterSelectionCubit, SemesterSelectionState>(
            builder: (context, state) {
              var semCount = state.semesterCount;
              if (state.status.isSubmissionInProgress) {
                return const CircularProgressIndicator();
              }
              if (semCount == null) {
                return const Text("Try Again");
              }
              return Column(
                children: [
                  SemesterDropDown<SemesterSelectionCubit,
                      SemesterSelectionState>(
                    onChanged: (cubit, value) => cubit.onSemesterChanged(value),
                    getSemCount: semCount,
                    getSelectedValue: (state) => state.selectedSemester,
                    dropdownMaxHeight: 200,
                  ),
                  CsMaterialButton<SemesterSelectionCubit, SemesterSelectionState>(
                    isEnabled: (state) => state.selectedSemester != null,
                    onPressed: (cubit) {
                      cubit.saveSelectedSemester();
                      _homeCubit.updateSelectedSemester(state.selectedSemester);
                      WidgetUtils.showSnackBar(context, "Saved!");
                      Navigator.pop(context);
                    },
                    text: "Save",
                  )
                ],
              ).paddingForAll(16);
            },
          ).paddingWithSymmetry(vertical: 50)
        ],
      ),
    );
  }
}
