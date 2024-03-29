import 'dart:async';

import 'package:flutter/material.dart';

import '../services/base/interface/i_translations_service.dart';
import './dependency_injection.dart';

class TranslationsDelegate extends LocalizationsDelegate<ITranslationService> {
  final Locale? newLocale;

  const TranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return getLanguage()
        .supportedLanguagesCodes()
        .contains(locale.languageCode);
  }

  @override
  Future<ITranslationService> load(Locale locale) {
    return getTranslations().load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<ITranslationService> old) {
    return true;
  }
}
