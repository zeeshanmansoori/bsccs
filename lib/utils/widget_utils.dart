import 'package:bsccs/utils/constants.dart';
import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetUtils {
  static void showSnackBar(
    BuildContext context,
    String? msg, {
    Duration? duration,
  }) {
    if (msg == null || msg == "") return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(msg),
          behavior: SnackBarBehavior.floating,
          duration: duration ?? const Duration(milliseconds: 3000),
          //backgroundColor: Colors.red,
        ),
      );
  }

  static AppBar csAppBar({
    Widget? title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    String? titleText,
  }) {
    return AppBar(
      title: title ?? (titleText != null ? Text(titleText) : null),
      titleSpacing: 0,
      elevation: 1,
      actions: actions,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      bottom: bottom,
    );
  }

  static IconButton saveButton(void Function()? onPressed) {
    return IconButton(
      splashRadius: Constants.splashRadius,
      onPressed: onPressed,
      icon: const Icon(Icons.save),
    );
  }

  static Future showAlertDialog(
    BuildContext context, {
    required String title,
    required String description,
    required void Function() onConfirmClicked,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 24,
            ),
            titlePadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            buttonPadding: EdgeInsets.zero,
            actionsPadding: const EdgeInsets.only(bottom: 16),
            title: Text(title),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            contentTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(description),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"))
                  .paddingWithSymmetry(horizontal: 16),
              ElevatedButton(
                onPressed: onConfirmClicked,
                child: const Text("Confirm"),
              ).paddingWithSymmetry(horizontal: 16),
            ],
          );
        });
  }
}
