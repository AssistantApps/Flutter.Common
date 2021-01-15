import 'package:flutter/material.dart';

import 'dateHelper.dart';

String getVersionReleaseDate(BuildContext context, bool isCurrentVersion,
    DateTime dateTime, String pendingAppStoreRelease) {
  if (dateTime.isAfter(DateTime.now())) {
    if (isCurrentVersion) return simpleDate(DateTime.now());
    return pendingAppStoreRelease;
  }
  return simpleDate(dateTime);
}
