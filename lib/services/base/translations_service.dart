import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../components/tilePresenters/language_tile_presenter.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/localization_map.dart';
import '../../contracts/search/dropdown_option.dart';
import '../../integration/dependency_injection.dart';
import '../../pages/dialog/options_list_page_dialog.dart';
import './interface/i_translations_service.dart';

class TranslationService implements ITranslationService {
  Locale? locale;
  Map<dynamic, dynamic> _localisedValues = <dynamic, dynamic>{};

  @override
  Future<ITranslationService> load(Locale locale) async {
    this.locale = locale;
    String languageCode = locale.languageCode;
    List<String> supportedLanguagesCodes =
        getLanguage().supportedLanguagesCodes();
    if (supportedLanguagesCodes.contains(languageCode) == false) {
      languageCode = getLanguage().defaultLanguageMap().code;
      this.locale = Locale(languageCode);
    }
    getLog().d(languageCode);

    String jsonContent =
        await rootBundle.loadString('assets/lang/language.$languageCode.json');
    _localisedValues = json.decode(jsonContent);
    return this;
  }

  @override
  get currentLanguage => locale?.languageCode;

  @override
  String fromKey(LocaleKey key) {
    String keyString = EnumToString.convertToString(key);
    return fromString(keyString);
  }

  @override
  String fromString(String keyString) {
    return _localisedValues[keyString] ?? keyString;
  }

  @override
  LocalizationMap getCurrentLocalizationMap(
      BuildContext context, String currentLanguageCodeSetting) {
    List<LocalizationMap> supportedLanguageMaps =
        getLanguage().getLocalizationMaps();
    LocalizationMap? currentLocal = supportedLanguageMaps.firstWhereOrNull(
        (LocalizationMap localizationMap) =>
            localizationMap.code == currentLanguageCodeSetting);
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
      return const Locale('en');
    }
    return Locale(supportedLanguageKey);
  }

  @override
  Locale getLocaleFromLocalMap(LocalizationMap localeMap) =>
      Locale(localeMap.code);

  @override
  Future<String?> langaugeSelectionPage(BuildContext context) async {
    List<LocalizationMap> supportedLanguageMaps =
        getLanguage().getLocalizationMaps();
    List<DropdownOption> orderedLangs = supportedLanguageMaps
        .map((l) => DropdownOption(
              getTranslations().fromKey(l.name),
              value: l.code,
            ))
        .toList();
    orderedLangs.sort((a, b) => a.title.compareTo(b.title));
    String? dialogResult = await getNavigation().navigateAsync<String>(
      context,
      navigateTo: (context) => OptionsListPageDialog(
        getTranslations().fromKey(LocaleKey.appLanguage),
        orderedLangs,
        minListForSearch: 15,
        customPresenter: (
          BuildContext innerC,
          DropdownOption opt,
          int index, {
          void Function()? onTap,
        }) {
          LocalizationMap supportedLang =
              supportedLanguageMaps.firstWhere((sl) => sl.code == opt.value);
          return languageTilePresenter(
            innerC,
            opt.title,
            supportedLang.countryCode,
            percentageComplete: supportedLang.percentageComplete,
            onTap: () => getNavigation().pop(context, opt.value),
          );
        },
      ),
    );
    return dialogResult;
  }
}
