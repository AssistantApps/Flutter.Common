import 'package:flutter/material.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

String getFriendlyTimeLeft(BuildContext context, int millisecondsLeft) {
  if (millisecondsLeft <= 0)
    return getTranslations().fromKey(LocaleKey.completed);

  var seconds = millisecondsLeft / 1000;
  if (seconds < 1) return getTranslations().fromKey(LocaleKey.completed);
  if (seconds < 60)
    return getTranslations()
        .fromKey(LocaleKey.seconds)
        .replaceAll('{0}', seconds.toStringAsFixed(0));

  var minutes = seconds / 60;
  if (minutes < 1)
    return getTranslations()
        .fromKey(LocaleKey.seconds)
        .replaceAll('{0}', seconds.toStringAsFixed(0));
  if (minutes < 60)
    return getTranslations()
        .fromKey(LocaleKey.minutes)
        .replaceAll('{0}', minutes.toStringAsFixed(0));

  var hours = minutes / 60;
  if (hours < 1)
    return getTranslations()
        .fromKey(LocaleKey.minutes)
        .replaceAll('{0}', minutes.toStringAsFixed(0));
  if (hours < 60)
    return getTranslations()
        .fromKey(LocaleKey.hours)
        .replaceAll('{0}', hours.toStringAsFixed(0));

  var days = hours / 24;
  if (days < 1)
    return getTranslations()
        .fromKey(LocaleKey.hours)
        .replaceAll('{0}', hours.toStringAsFixed(0));
  return getTranslations()
      .fromKey(LocaleKey.days)
      .replaceAll('{0}', days.toStringAsFixed(0));
}
