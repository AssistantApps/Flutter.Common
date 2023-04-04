// To parse this JSON data, do
//
//     final assistantAppsLink = assistantAppsLinkFromJson(jsonString);

import 'dart:convert';

import '../../helpers/json_helper.dart';

class AssistantAppsLinkViewModel {
  String shortCode;
  String game;
  String title;
  String titleStart;
  String titleEnd;
  String link;
  String image;
  String icon;
  String screenshotLeft;
  String screenshotRight;
  String description;
  String documentation;
  String downloadAppLink;
  String customPrimaryColour;
  List<AssistantAppsLinkLinkViewModel> links;

  AssistantAppsLinkViewModel({
    required this.shortCode,
    required this.game,
    required this.title,
    required this.titleStart,
    required this.titleEnd,
    required this.link,
    required this.image,
    required this.icon,
    required this.screenshotLeft,
    required this.screenshotRight,
    required this.description,
    required this.documentation,
    required this.downloadAppLink,
    required this.customPrimaryColour,
    required this.links,
  });

  factory AssistantAppsLinkViewModel.fromRawJson(String str) =>
      AssistantAppsLinkViewModel.fromJson(json.decode(str));

  factory AssistantAppsLinkViewModel.fromJson(Map<String, dynamic> json) =>
      AssistantAppsLinkViewModel(
        shortCode: readStringSafe(json, 'shortCode'),
        game: readStringSafe(json, 'game'),
        title: readStringSafe(json, 'title'),
        titleStart: readStringSafe(json, 'titleStart'),
        titleEnd: readStringSafe(json, 'titleEnd'),
        link: readStringSafe(json, 'link'),
        image: readStringSafe(json, 'image'),
        icon: readStringSafe(json, 'icon'),
        screenshotLeft: readStringSafe(json, 'screenshotLeft'),
        screenshotRight: readStringSafe(json, 'screenshotRight'),
        description: readStringSafe(json, 'description'),
        documentation: readStringSafe(json, 'documentation'),
        downloadAppLink: readStringSafe(json, 'downloadAppLink'),
        customPrimaryColour: readStringSafe(json, 'customPrimaryColour'),
        links: readListSafe(
          json,
          'links',
          (x) => AssistantAppsLinkLinkViewModel.fromJson(x),
        ),
      );

  // AssistantAppsLinkViewModel copyWith({
  //   String? guid,
  //   AssistantAppType? type,
  //   String? name,
  //   String? gameName,
  //   String? iconUrl,
  //   String? logoUrl,
  //   List<Link>? links,
  //   bool? isVisible,
  //   int? sortOrder,
  // }) {
  //   return AssistantAppsLinkViewModel(
  //     guid: guid ?? this.guid,
  //     type: type ?? this.type,
  //     name: name ?? this.name,
  //     gameName: gameName ?? this.gameName,
  //     iconUrl: iconUrl ?? this.iconUrl,
  //     logoUrl: logoUrl ?? this.logoUrl,
  //     links: links ?? this.links,
  //     isVisible: isVisible ?? this.isVisible,
  //     sortOrder: sortOrder ?? this.sortOrder,
  //   );
  // }
}

class AssistantAppsLinkLinkViewModel {
  AssistantAppsLinkLinkViewModel({
    required this.title,
    required this.icon,
    required this.url,
  });

  String title;
  String icon;
  String url;

  factory AssistantAppsLinkLinkViewModel.fromRawJson(String str) =>
      AssistantAppsLinkLinkViewModel.fromJson(json.decode(str));

  factory AssistantAppsLinkLinkViewModel.fromJson(Map<String, dynamic> json) =>
      AssistantAppsLinkLinkViewModel(
        title: readStringSafe(json, 'title'),
        icon: readStringSafe(json, 'icon'),
        url: readStringSafe(json, 'url'),
      );
}
