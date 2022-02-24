import 'package:flutter/material.dart';

import '../contracts/enum/localeKey.dart';
import '../integration/dependencyInjection.dart';
import 'dateHelper.dart';

String getVersionReleaseDate(bool isCurrentVersion, DateTime dateTime) {
  if (dateTime.isAfter(DateTime.now())) {
    if (isCurrentVersion) return simpleDate(DateTime.now());
    return getTranslations().fromKey(LocaleKey.pendingAppStoreRelease);
  }
  return simpleDate(dateTime);
}

IconData? getVersionIcon(bool isCurrentVersion, DateTime dateTime) {
  if (dateTime.isAfter(DateTime.now())) {
    if (isCurrentVersion) return Icons.check;
    return Icons.hourglass_empty_rounded;
  }
  return Icons.check;
}
