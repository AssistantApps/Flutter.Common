import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:time_formatter/time_formatter.dart';

import '../components/common/percent.dart';
import '../contracts/enum/locale_key.dart';
import '../integration/dependencyInjection.dart';
import './timeHelper.dart';

String simpleDate(DateTime dateTime) =>
    "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

bool isValentinesPeriod() => isWithinPeriod(month: 2, minDay: 13, maxDay: 15);
bool isChristmasPeriod() => isWithinPeriod(month: 12, minDay: 20, maxDay: 31);

bool isWithinPeriod(
    {required int month, required int minDay, required int maxDay}) {
  var currentDate = DateTime.now();
  if (currentDate.month == month && //
      currentDate.day > minDay && //
      currentDate.day < maxDay) {
    return true;
  }
  return false;
}

String friendlyTimeSince(DateTime date) {
  return formatTime(date.toLocal().millisecondsSinceEpoch);
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

  return HorizontalProgressBar(
    percent: percentage.toDouble(),
    animation: animation,
    text: Text(
      '${percentage.toStringAsFixed(0)}% - $timeLeft',
      style: const TextStyle(color: Colors.black),
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
