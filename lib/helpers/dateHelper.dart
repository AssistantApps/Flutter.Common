import 'package:flutter/material.dart';

import '../components/common/percent.dart';
import '../contracts/enum/localeKey.dart';
import '../integration/dependencyInjection.dart';
import 'timeHelper.dart';

String simpleDate(DateTime dateTime) =>
    "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

bool isValentinesPeriod() {
  var currentDate = DateTime.now();
  if (currentDate.month == 2 && currentDate.day >= 13 && currentDate.day < 15) {
    return true;
  }
  return false;
}

Widget getProgressbarFromDates(
  BuildContext context,
  DateTime startDate,
  DateTime endDate, {
  bool animation = false,
}) {
  int startDateInMilli = startDate.millisecondsSinceEpoch;
  int endDateInMilli = endDate.millisecondsSinceEpoch;
  DateTime now = DateTime.now();

  double percentage = getPercentageFromDates(startDate, endDate);
  String timeLeft = getTranslations().fromKey(LocaleKey.completed);
  if (startDateInMilli > now.millisecondsSinceEpoch) {
    timeLeft = getTranslations().fromKey(LocaleKey.notStarted);
  } else if (startDateInMilli < endDateInMilli) {
    int milliLeft = endDateInMilli - now.millisecondsSinceEpoch;
    timeLeft = getFriendlyTimeLeft(context, milliLeft);
  }

  return horizontalProgressBar(
    context,
    percentage.toDouble(),
    animation: animation,
    text: Text(
      '${percentage.toStringAsFixed(0)}% - $timeLeft',
      style: TextStyle(color: Colors.black),
    ),
  );
}

double getPercentageFromDates(
  DateTime startDate,
  DateTime endDate,
) {
  int startDateInMilli = startDate.millisecondsSinceEpoch;
  int endDateInMilli = endDate.millisecondsSinceEpoch;
  DateTime now = DateTime.now();

  double percentage = 1.0;
  if (startDateInMilli > now.millisecondsSinceEpoch) {
    percentage = 0.0;
  } else if (startDateInMilli < endDateInMilli) {
    int totalMilli = endDateInMilli - startDateInMilli;
    int milliPassed = now.millisecondsSinceEpoch - startDateInMilli;
    double temp = milliPassed / totalMilli;

    if (temp >= 0.0 && temp <= 1.0) percentage = temp;
  }

  return (percentage * 100);
}
