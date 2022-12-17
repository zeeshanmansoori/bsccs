import 'package:bsccs/utils/constants.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({
    Key? key,
    this.radius = Constants.cardRadius,
  }) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    var cardBorderRadius = BorderRadius.circular(radius);
    return Container(
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(.5), borderRadius: cardBorderRadius),
    );
  }
}
