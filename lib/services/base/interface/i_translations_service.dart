import 'dart:async';

import 'package:flutter/material.dart';

import '../../../contracts/enum/locale_key.dart';
import '../../../contracts/localization_map.dart';

abstract class ITranslationService {
  Future<ITranslationService> load(Locale locale);

  get currentLanguage => 'en';
  String fromKey(LocaleKey key);
  String fromString(String key);

  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting);

  Locale getLocaleFromKey(String supportedLanguageKey);
  Locale getLocaleFromLocalMap(LocalizationMap localeMap);

  Future<String?> langaugeSelectionPage(BuildContext context) async => 'en';
}
