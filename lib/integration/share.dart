import 'package:share/share.dart';

import '../contracts/enum/localeKey.dart';
import 'dependencyInjection.dart';

shareText(LocaleKey localeKey) {
  Share.share(getTranslations().fromKey(localeKey));
}