import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../integration/dependency_injection.dart';

class HorizontalProgressBar extends StatelessWidget {
  final double percent;
  final bool animation;
  final Widget? text;

  const HorizontalProgressBar({
    super.key,
    required this.percent,
    this.animation = true,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    double localPercent = percent / 100;
    String displayPercent = percent.toStringAsFixed(0);

    return LinearPercentIndicator(
      animation: animation,
      lineHeight: 20.0,
      animationDuration: 2500,
      percent: localPercent,
      center: text ?? Text('$displayPercent %'),
      // linearStrokeCap: LinearStrokeCap.roundAll,
      barRadius: const Radius.circular(8),
      progressColor: getTheme().getSecondaryColour(context),
      backgroundColor: getTheme().getCardBackgroundColour(context),
    );
  }
}
