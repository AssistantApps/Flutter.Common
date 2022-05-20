import 'package:share_plus/share_plus.dart';

import '../contracts/enum/localeKey.dart';
import 'dependencyInjection.dart';

void shareText(LocaleKey localeKey) {
  shareTextManual(getTranslations().fromKey(localeKey));
}

void shareTextManual(String text) {
  Share.share(text);
}
