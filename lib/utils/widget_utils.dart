import 'package:flutter/material.dart';

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
}
