import 'dart:async';

import 'package:flutter/material.dart';

import '../services/base/interface/ITranslationsService.dart';
import 'dependencyInjection.dart';

class TranslationsDelegate extends LocalizationsDelegate<ITranslationService> {
  final Locale newLocale;

  const TranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return getLanguage()
        .supportedLanguagesCodes()
        .contains(locale.languageCode);
  }

  @override
  Future<ITranslationService> load(Locale locale) {
    getLog().d('load: ' + locale.languageCode);
    return getTranslations().load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<ITranslationService> old) {
    return true;
  }
}
