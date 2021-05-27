import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget horizontalProgressBar(BuildContext context, double percent,
    {bool animation = true, Widget text}) {
  double localPercent = percent;
  String displayPercent = percent.toStringAsFixed(0);
  if (percent > 1) {
    localPercent = percent / 100;
  } else {
    displayPercent = (percent * 100).toStringAsFixed(0);
  }

  return LinearPercentIndicator(
    animation: animation,
    lineHeight: 20.0,
    animationDuration: 2500,
    percent: localPercent,
    center: text ?? Text('$displayPercent %'),
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: getTheme().getSecondaryColour(context),
    backgroundColor: getTheme().getBackgroundColour(context),
  );
}
