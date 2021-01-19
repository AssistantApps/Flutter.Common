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
