import 'dart:convert';

import '../enum/platform_type.dart';

class VersionSearchViewModel {
  String appGuid;
  List<PlatformType> platforms;
  String languageCode;
  int page;

  VersionSearchViewModel({
    required this.appGuid,
    required this.platforms,
    required this.languageCode,
    required this.page,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "AppGuid": appGuid,
        "Platforms": List<dynamic>.from(
            platforms.map((p) => platformTypeValues.reverse[p])),
        "LanguageCode": languageCode,
        "Page": page,
      };
}
