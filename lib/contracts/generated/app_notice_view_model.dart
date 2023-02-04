// To parse this JSON data, do
//
//     final communityMissionProgressItemViewModel = communityMissionProgressItemViewModelFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class AppNoticeViewModel {
  final String guid;
  final String appGuid;
  final String name;
  final String subtitle;
  final String iconUrl;
  final String externalUrl;
  final String languageCode;
  final List<PlatformType> platforms;
  final bool isVisible;
  final DateTime endDate;
  final int sortOrder;

  AppNoticeViewModel({
    required this.guid,
    required this.appGuid,
    required this.name,
    required this.subtitle,
    required this.iconUrl,
    required this.externalUrl,
    required this.languageCode,
    required this.platforms,
    required this.isVisible,
    required this.endDate,
    required this.sortOrder,
  });

  factory AppNoticeViewModel.fromRawJson(String str) =>
      AppNoticeViewModel.fromJson(json.decode(str));

  factory AppNoticeViewModel.fromJson(Map<String, dynamic> json) =>
      AppNoticeViewModel(
        guid: readStringSafe(json, 'guid'),
        appGuid: readStringSafe(json, 'appGuid'),
        name: readStringSafe(json, 'name'),
        subtitle: readStringSafe(json, 'subtitle'),
        iconUrl: readStringSafe(json, 'iconUrl'),
        externalUrl: readStringSafe(json, 'externalUrl'),
        languageCode: readStringSafe(json, 'languageCode'),
        platforms: readListSafe(
          json,
          'platforms',
          (dynamic innerJson) => platformTypeValues.map[innerJson.toString()]!,
        ),
        isVisible: readBoolSafe(json, 'isVisible'),
        endDate: readDateSafe(json, 'endDate'),
        sortOrder: readIntSafe(json, 'sortOrder'),
      );
}
