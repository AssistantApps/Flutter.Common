import 'package:share_plus/share_plus.dart';

import '../contracts/enum/localeKey.dart';
import 'dependencyInjection.dart';

shareText(LocaleKey localeKey) {
  shareTextManual(getTranslations().fromKey(localeKey));
}

shareTextManual(String text) {
  Share.share(text);
}
