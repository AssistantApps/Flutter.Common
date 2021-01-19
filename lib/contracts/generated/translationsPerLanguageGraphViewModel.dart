// To parse this JSON data, do
//
//     final translationsPerLanguageGraphViewModel = translationsPerLanguageGraphViewModelFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

class TranslationsPerLanguageGraphViewModel {
  TranslationsPerLanguageGraphViewModel({
    this.guid,
    this.name,
    this.languageCode,
    this.countryCode,
    this.numTranslations,
    this.percentage,
  });

  final String guid;
  final String name;
  final String languageCode;
  final String countryCode;
  final int numTranslations;
  final int percentage;

  factory TranslationsPerLanguageGraphViewModel.fromRawJson(String str) =>
      TranslationsPerLanguageGraphViewModel.fromJson(json.decode(str));

  factory TranslationsPerLanguageGraphViewModel.fromJson(
          Map<String, dynamic> json) =>
      TranslationsPerLanguageGraphViewModel(
        guid: readStringSafe(json, 'guid'),
        name: readStringSafe(json, 'name'),
        languageCode: readStringSafe(json, 'languageCode'),
        countryCode: readStringSafe(json, 'countryCode'),
        numTranslations: readIntSafe(json, 'numTranslations'),
        percentage: readIntSafe(json, 'percentage'),
      );
}
