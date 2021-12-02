import 'dart:async';

import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/localizationMap.dart';

abstract class ITranslationService {
  Future<ITranslationService> load(Locale locale);

  get currentLanguage => 'en';
  String fromKey(LocaleKey key);
  String fromString(String key);

  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting);

  Locale getLocaleFromKey(String supportedLanguageKey);
  Locale getLocaleFromLocalMap(LocalizationMap localeMap);
}
