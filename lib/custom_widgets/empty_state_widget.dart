import 'package:bsccs/custom_widgets/adbox_widget.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ).paddingForAll(20),
        CsBannerAd.resizableAdBox()
            .paddingWithSymmetry(horizontal: 20)
            .expanded(flex: 1),
      ],
    );
  }
}
