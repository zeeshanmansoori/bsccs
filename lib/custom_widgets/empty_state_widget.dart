import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    Key? key,
    this.message = "No data available",
  }) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(message).wrapCenter();
  }
}
