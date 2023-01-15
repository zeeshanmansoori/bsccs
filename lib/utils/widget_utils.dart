import 'package:bsccs/utils/constants.dart';
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

}
