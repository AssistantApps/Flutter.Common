import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../contracts/localization_map.dart';
import './interface/i_language_service.dart';

class LanguageService implements ILanguageService {
  @override
  LocalizationMap defaultLanguageMap() =>
      LocalizationMap(LocaleKey.english, 'en', 'gb');

  @override
  List<LocalizationMap> getLocalizationMaps() {
    List<LocalizationMap> supportedLanguageMaps = [
      defaultLanguageMap(),
      LocalizationMap(LocaleKey.dutch, 'nl', 'nl'),
      LocalizationMap(LocaleKey.german, 'de', 'de'),
      LocalizationMap(LocaleKey.french, 'fr', 'fr'),
      LocalizationMap(LocaleKey.italian, 'it', 'it'),
      LocalizationMap(LocaleKey.russian, 'ru', 'ru'),
      LocalizationMap(LocaleKey.polish, 'pl', 'pl'),
      LocalizationMap(LocaleKey.brazilianPortuguese, 'pt-br', 'br'),
      LocalizationMap(LocaleKey.portuguese, 'pt', 'pt'),
      LocalizationMap(LocaleKey.norwegian, 'no', 'no'),
      LocalizationMap(LocaleKey.romanian, 'ro', 'ro'),
      LocalizationMap(LocaleKey.spanish, 'es', 'es'),
      LocalizationMap(LocaleKey.czech, 'cs', 'cz'),
      LocalizationMap(LocaleKey.turkish, 'tr', 'tr'),
      LocalizationMap(LocaleKey.hungarian, 'hu', 'hu'),
      LocalizationMap(LocaleKey.simplifiedChinese, 'zh-hans', 'cn'),
      LocalizationMap(LocaleKey.traditionalChinese, 'zh-hant', 'cn'),
      LocalizationMap(LocaleKey.arabic, 'ar', 'ar'),
      LocalizationMap(LocaleKey.vietnamese, 'vi-vn', 'vn'),
      LocalizationMap(LocaleKey.urdu, 'ur', 'pk'),
      LocalizationMap(LocaleKey.filipino, 'ph', 'ph'),
      LocalizationMap(LocaleKey.indonesian, 'id', 'id'),
      LocalizationMap(LocaleKey.malaysian, 'ms', 'my'),
      LocalizationMap(LocaleKey.tagalog, 'tl', 'ph'),
      LocalizationMap(LocaleKey.afrikaans, 'af', 'za'),
      // LocalizationMap(LocaleKey.arabic, 'ar', 'ar'),
    ];
    return supportedLanguageMaps;
  }

  @override
  List<Locale> supportedLocales() =>
      getLocalizationMaps().map((l) => Locale(l.code, "")).toList();

  @override
  List<LocaleKey> supportedLanguages() =>
      getLocalizationMaps().map((l) => l.name).toList();

  @override
  List<String> supportedLanguagesCodes() =>
      getLocalizationMaps().map((l) => l.code).toList();
}
