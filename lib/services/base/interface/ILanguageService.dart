import 'package:flutter/material.dart';

import '../../../contracts/enum/locale_key.dart';
import '../../../contracts/localizationMap.dart';

abstract class ILanguageService {
  LocalizationMap defaultLanguageMap();

  List<LocalizationMap> getLocalizationMaps();
  List<Locale> supportedLocales();
  List<LocaleKey> supportedLanguages();
  List<String> supportedLanguagesCodes();
}
