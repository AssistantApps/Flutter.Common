import 'package:flutter/material.dart';

import '../contracts/enum/locale_key.dart';
import '../integration/dependencyInjection.dart';
import './date_helper.dart';

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
