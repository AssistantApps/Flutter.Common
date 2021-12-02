import 'dart:async';
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../contracts/enum/localeKey.dart';
import '../../contracts/localizationMap.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/ITranslationsService.dart';

class TranslationService implements ITranslationService {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  @override
  Future<ITranslationService> load(Locale locale) async {
    this.locale = locale;
    String languageCode = locale?.languageCode ?? '';
    if (getLanguage().getLocalizationMaps().contains(languageCode) == false) {
      languageCode = getLanguage().defaultLanguageMap().code;
      this.locale = Locale(languageCode);
    }

    String jsonContent =
        await rootBundle.loadString('assets/lang/language.$languageCode.json');
    _localisedValues = json.decode(jsonContent);
    return this;
  }

  get currentLanguage => locale.languageCode;

  @override
  String fromKey(LocaleKey key) {
    String keyString = EnumToString.convertToString(key);
    return fromString(keyString);
  }

  @override
  String fromString(String keyString) {
    return _localisedValues[keyString] ?? "$keyString";
  }

  @override
  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting) {
    List<LocalizationMap> supportedLanguageMaps =
        getLanguage().getLocalizationMaps();
    LocalizationMap currentLocal = supportedLanguageMaps.firstWhere(
      (LocalizationMap localizationMap) =>
          localizationMap.code == currentLanguageCodeSetting,
      orElse: () => null,
    );
    if (currentLocal == null) {
      Locale deviceLocale = Localizations.localeOf(context);
      currentLocal = supportedLanguageMaps.firstWhere(
        (LocalizationMap localizationMap) =>
            localizationMap.code == deviceLocale.languageCode,
        orElse: () => getLanguage().defaultLanguageMap(),
      );
    }
    return currentLocal;
  }

  @override
  Locale getLocaleFromKey(String supportedLanguageKey) {
    int langIndex =
        getLanguage().supportedLanguagesCodes().indexOf(supportedLanguageKey);
    if (langIndex < 0) {
      getLog()
          .e('language not found ($supportedLanguageKey), revert to english');
      return Locale('en');
    }
    return Locale(supportedLanguageKey);
  }

  @override
  Locale getLocaleFromLocalMap(LocalizationMap localeMap) =>
      Locale(localeMap.code);
}
