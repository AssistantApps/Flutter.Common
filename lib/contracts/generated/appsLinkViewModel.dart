// To parse this JSON data, do
//
//     final assistantAppsLink = assistantAppsLinkFromJson(jsonString);

import 'dart:convert';

import '../../helpers/jsonHelper.dart';
import '../enum/assistantAppType.dart';

class AssistantAppsLinkViewModel {
  AssistantAppsLinkViewModel({
    required this.guid,
    required this.type,
    required this.name,
    required this.gameName,
    required this.iconUrl,
    required this.logoUrl,
    required this.links,
    required this.isVisible,
    required this.sortOrder,
  });

  String guid;
  AssistantAppType type;
  String name;
  String gameName;
  String iconUrl;
  String logoUrl;
  List<Link> links;
  bool isVisible;
  int sortOrder;

  factory AssistantAppsLinkViewModel.fromRawJson(String str) =>
      AssistantAppsLinkViewModel.fromJson(json.decode(str));

  factory AssistantAppsLinkViewModel.fromJson(Map<String, dynamic> json) =>
      AssistantAppsLinkViewModel(
        guid: readStringSafe(json, 'guid'),
        type: assistantAppTypeValues.map[readStringSafe(json, 'type')] ??
            AssistantAppType.unknown,
        name: readStringSafe(json, 'name'),
        gameName: readStringSafe(json, 'gameName'),
        iconUrl: readStringSafe(json, 'iconUrl'),
        logoUrl: readStringSafe(json, 'logoUrl'),
        links: readListSafe(json, 'links', (x) => Link.fromJson(x)),
        isVisible: readBoolSafe(json, 'isVisible'),
        sortOrder: readIntSafe(json, 'sortOrder'),
      );

  AssistantAppsLinkViewModel copyWith({
    String? guid,
    AssistantAppType? type,
    String? name,
    String? gameName,
    String? iconUrl,
    String? logoUrl,
    List<Link>? links,
    bool? isVisible,
    int? sortOrder,
  }) {
    return AssistantAppsLinkViewModel(
      guid: guid ?? this.guid,
      type: type ?? this.type,
      name: name ?? this.name,
      gameName: gameName ?? this.gameName,
      iconUrl: iconUrl ?? this.iconUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      links: links ?? this.links,
      isVisible: isVisible ?? this.isVisible,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

class Link {
  Link({
    required this.type,
    required this.url,
  });

  String type;
  String url;

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        type: readStringSafe(json, 'type'),
        url: readStringSafe(json, 'url'),
      );
}
