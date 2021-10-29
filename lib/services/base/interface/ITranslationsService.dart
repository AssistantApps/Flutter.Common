import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/SupportedLanguages.dart';
import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/localizationMap.dart';

class ITranslationService {
  Future<ITranslationService> load(Locale locale) async {
    return this;
  }

  get currentLanguage => 'en';

  String fromKey(LocaleKey key) {
    return key.toString();
  }

  String fromString(String key) {
    return key;
  }

  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting) {
    return englishLanguageMap;
  }

  Locale getLocaleFromKey(String supportedLanguageKey) {
    return Locale(supportedLanguageKey);
  }

  Locale getLocaleFromLocalMap(LocalizationMap localeMap) =>
      Locale(localeMap.code);

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  Future<String> langaugeSelectionPage(BuildContext context) async => '';
}
