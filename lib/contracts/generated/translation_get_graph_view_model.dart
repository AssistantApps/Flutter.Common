// To parse this JSON data, do
//
//     final translationsPerLanguageGraphViewModel = translationsPerLanguageGraphViewModelFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/json_helper.dart';

class TranslationGetGraphViewModel {
  TranslationGetGraphViewModel({
    required this.appGuidList,
  });

  final List<String> appGuidList;

  factory TranslationGetGraphViewModel.fromRawJson(String str) =>
      TranslationGetGraphViewModel.fromJson(json.decode(str));

  factory TranslationGetGraphViewModel.fromJson(Map<String, dynamic> json) =>
      TranslationGetGraphViewModel(
        appGuidList: readListSafe<String>(
          json,
          'appGuidList',
          (dynamic innerJson) => innerJson,
        ),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'AppGuidList': appGuidList,
      };
}
