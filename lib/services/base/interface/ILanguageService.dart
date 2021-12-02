import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/localizationMap.dart';

abstract class ILanguageService {
  LocalizationMap defaultLanguageMap();

  List<LocalizationMap> getLocalizationMaps();
  List<Locale> supportedLocales();
  List<LocaleKey> supportedLanguages();
  List<String> supportedLanguagesCodes();
}
