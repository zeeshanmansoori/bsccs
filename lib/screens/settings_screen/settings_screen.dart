import 'package:bsccs/cubit/settings/settings_cubit.dart';
import 'package:bsccs/custom_widgets/semester_dropdown.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:bsccs/utils/utils.dart';
import 'package:bsccs/utils/widget_utils.dart';
import 'package:cs_repository/cs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../custom_widgets/cs_material_button.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as SettingsArguments;

    return BlocProvider(
      create: (context) => SettingsCubit(context.read<CsRepository>()),
      child: Scaffold(
        appBar: WidgetUtils.csAppBar(titleText: "Settings"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SemesterDropDown<SettingsCubit, SettingsState>(
              onChanged: (cubit, value) => cubit.onSemesterChanged(value),
              getSemCount: arguments.semesterCount,
              getSelectedValue: (state) => state.selectedSemester,
            ).paddingWithSymmetry(vertical: 10),
            ListTile(
              title: const Text(
                "Premium Features",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              trailing: SvgPicture.asset(
                Utils.getSvgPath("crown"),
                width: 25,
                height: 25,
              ).paddingForOnly(right: 15),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return SwitchListTile(
                  value: state.offlineModeEnabled,
                  onChanged: (value) {
                    context
                        .read<SettingsCubit>()
                        .onOfflineModeToggleChanged(value);
                    var msg = value
                        ? "Offline mode enabled"
                        : "Offline mode disabled";
                    WidgetUtils.showSnackBar(context, msg);
                  },
                  title: const Text("Offline mode"),
                );
              },
            ),
            const Spacer(
              flex: 1,
            ),
            CsMaterialButton<SettingsCubit, SettingsState>(
              isEnabled: (state) => state.selectedSemester != null,
              onPressed: (cubit) {
                cubit.saveSelectedSemester();
                WidgetUtils.showSnackBar(context, "Saved!");
              },
              text: "Save",
            ).wrapCenter().paddingForOnly(bottom: 16)
          ],
        ),
      ),
    );
  }

  static void navigate(
    BuildContext context,
    int semesterCount,
  ) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: SettingsArguments(semesterCount: semesterCount),
    );
  }
}

class SettingsArguments {
  final int semesterCount;

  const SettingsArguments({
    required this.semesterCount,
  });
}
