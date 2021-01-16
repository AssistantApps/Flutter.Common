import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constants/SupportedLanguages.dart';
import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/localizationMap.dart';

class ITranslationService {
  Future<ITranslationService> load(Locale locale) async {
    return this;
  }

  String fromKey(LocaleKey key) {
    return "${key.toString()}";
  }

  @Deprecated('Temporary method, preferably use fromKey(LocaleKey)')
  String fromString(String key) {
    return "${key.toString()}";
  }

  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting) {
    return englishLanguageMap;
  }

  Locale getLocaleFromKey(String supportedLanguageKey) {
    return Locale(supportedLanguageKey);
  }
}
