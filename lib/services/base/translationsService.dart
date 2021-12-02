import 'dart:async';
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../components/tilePresenters/languageTilePresenter.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/localizationMap.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../integration/dependencyInjection.dart';
import '../../pages/dialog/optionsListPageDialog.dart';
import 'interface/ITranslationsService.dart';

class TranslationService implements ITranslationService {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  @override
  Future<ITranslationService> load(Locale locale) async {
    this.locale = locale;
    String languageCode = locale?.languageCode ?? '';
    if (getLocalizationMaps().contains(languageCode) == false) {
      languageCode = defaultLanguageMap().code;
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
    List<LocalizationMap> supportedLanguageMaps = getLocalizationMaps();
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
        orElse: () => defaultLanguageMap(),
      );
    }
    return currentLocal;
  }

  @override
  Locale getLocaleFromKey(String supportedLanguageKey) {
    int langIndex = supportedLanguagesCodes().indexOf(supportedLanguageKey);
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

  @override
  LocalizationMap defaultLanguageMap() =>
      LocalizationMap(LocaleKey.english, 'en', 'gb');

  @override
  List<LocalizationMap> getLocalizationMaps() {
    List<LocalizationMap> supportedLanguageMaps = [
      defaultLanguageMap(),
      LocalizationMap(LocaleKey.dutch, 'nl', 'nl'),
      LocalizationMap(LocaleKey.french, 'fr', 'fr'),
      LocalizationMap(LocaleKey.german, 'de', 'de'),
      LocalizationMap(LocaleKey.italian, 'it', 'it'),
      LocalizationMap(LocaleKey.indonesian, 'id', 'id'),
      LocalizationMap(LocaleKey.brazilianPortuguese, 'pt-br', 'br'),
      LocalizationMap(LocaleKey.polish, 'pl', 'pl'),
      LocalizationMap(LocaleKey.portuguese, 'pt', 'pt'),
      LocalizationMap(LocaleKey.romanian, 'ro', 'ro'),
      LocalizationMap(LocaleKey.russian, 'ru', 'ru'),
      LocalizationMap(LocaleKey.spanish, 'es', 'es'),
      LocalizationMap(LocaleKey.czech, 'cs', 'cz'),
      LocalizationMap(LocaleKey.turkish, 'tr', 'tr'),
      LocalizationMap(LocaleKey.hungarian, 'hu', 'hu'),
      LocalizationMap(LocaleKey.simplifiedChinese, 'zh-hans', 'cn'),
      LocalizationMap(LocaleKey.traditionalChinese, 'zh-hant', 'cn'),
      LocalizationMap(LocaleKey.norwegian, 'no', 'no'),
      LocalizationMap(LocaleKey.afrikaans, 'af', 'za'),
      // LocalizationMap(LocaleKey.arabic, 'ar', 'ar'),
    ];
    return supportedLanguageMaps;
  }

  List<Locale> supportedLocales() =>
      getLocalizationMaps().map((l) => Locale(l.code, "")).toList();
  List<LocaleKey> supportedLanguages() =>
      getLocalizationMaps().map((l) => l.name).toList();
  List<String> supportedLanguagesCodes() =>
      getLocalizationMaps().map((l) => l.code).toList();

  @override
  Future<String> langaugeSelectionPage(BuildContext context) async {
    List<LocalizationMap> supportedLanguageMaps = getLocalizationMaps();
    List<DropdownOption> orderedLangs = supportedLanguageMaps
        .map((l) => DropdownOption(
              getTranslations().fromKey(l.name),
              value: l.code,
            ))
        .toList();
    orderedLangs.sort((a, b) => a.title.compareTo(b.title));
    return await getNavigation().navigateAsync<String>(
      context,
      navigateTo: (context) => OptionsListPageDialog(
        getTranslations().fromKey(LocaleKey.language),
        orderedLangs,
        minListForSearch: 15,
        customPresenter: (BuildContext innerC, DropdownOption opt, int index) {
          LocalizationMap supportedLang =
              supportedLanguageMaps.firstWhere((sl) => sl.code == opt.value);
          return languageTilePresenter(
            innerC,
            opt.title,
            supportedLang.countryCode,
            onTap: () => Navigator.of(context).pop(opt.value),
          );
        },
      ),
    );
  }
}
