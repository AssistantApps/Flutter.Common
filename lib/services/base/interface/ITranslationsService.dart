import 'dart:async';

import 'package:flutter/material.dart';

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
          BuildContext context, String currentLanguageCodeSetting) =>
      defaultLanguageMap();

  Locale getLocaleFromKey(String supportedLanguageKey) =>
      Locale(supportedLanguageKey);

  Locale getLocaleFromLocalMap(LocalizationMap localeMap) =>
      Locale(localeMap.code);

  LocalizationMap defaultLanguageMap() =>
      LocalizationMap(LocaleKey.english, 'en', 'gb');

  List<LocalizationMap> getLocalizationMaps() => List.empty();
  List<Locale> supportedLocales() => List.empty();
  List<LocaleKey> supportedLanguages() => List.empty();
  List<String> supportedLanguagesCodes() => List.empty();

  Future<String> langaugeSelectionPage(BuildContext context) async => '';
}
