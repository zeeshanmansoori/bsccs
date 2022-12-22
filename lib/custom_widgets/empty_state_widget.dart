import 'package:bsccs/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Empty screen").wrapCenter();
  }
}
