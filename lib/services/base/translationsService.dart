import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../components/tilePresenters/languageTilePresenter.dart';
import '../../constants/SupportedLanguages.dart';
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
    String jsonContent = await rootBundle
        .loadString("assets/lang/language.${locale.languageCode}.json");
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
        orElse: () => englishLanguageMap,
      );
    }
    return currentLocal;
  }

  @override
  Locale getLocaleFromKey(String supportedLanguageKey) {
    int langIndex = supportedLanguagesCodes.indexOf(supportedLanguageKey);
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
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  @override
  Future<String> langaugeSelectionPage(BuildContext context) async {
    var orderedLangs = supportedLanguageMaps
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
