import 'package:share_plus/share_plus.dart';

import '../contracts/enum/locale_key.dart';
import './dependency_injection.dart';

void shareText(LocaleKey localeKey) {
  shareTextManual(getTranslations().fromKey(localeKey));
}

void shareTextManual(String text) {
  Share.share(text);
}
