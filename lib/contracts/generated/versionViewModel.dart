import 'dart:convert';

import '../../helpers/jsonHelper.dart';
import '../enum/platformType.dart';

class VersionViewModel {
  String guid;
  String appGuid;
  String markdown;
  String buildName;
  int buildNumber;
  List<PlatformType> platforms;
  DateTime activeDate;

  VersionViewModel({
    required this.guid,
    required this.appGuid,
    required this.markdown,
    required this.buildName,
    required this.buildNumber,
    required this.platforms,
    required this.activeDate,
  });

  factory VersionViewModel.empty() =>
      VersionViewModel.fromJson(json.decode("{}"));

  factory VersionViewModel.fromRawJson(String str) =>
      VersionViewModel.fromJson(json.decode(str));

  factory VersionViewModel.fromJson(Map<String, dynamic> json) =>
      VersionViewModel(
        guid: readStringSafe(json, 'guid'),
        appGuid: readStringSafe(json, 'appGuid'),
        markdown: readStringSafe(json, 'markdown'),
        buildName: readStringSafe(json, 'buildName'),
        buildNumber: readIntSafe(json, 'buildNumber'),
        platforms: readListSafe(json, 'platforms',
            (dynamic innerJson) => platformTypeValues.map[innerJson]!),
        activeDate: readDateSafe(json, 'activeDate'),
      );
}
