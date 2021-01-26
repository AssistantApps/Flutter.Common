// To parse this JSON data, do
//
//     final assistantAppLinks = assistantAppLinksFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

class AssistantAppLinks {
  AssistantAppLinks({
    this.name,
    this.icon,
    this.home,
    this.ios,
    this.android,
    this.web,
  });

  final String name;
  final String icon;
  final String home;
  final String ios;
  final String android;
  final String web;

  factory AssistantAppLinks.fromRawJson(String str) =>
      AssistantAppLinks.fromJson(json.decode(str));

  factory AssistantAppLinks.fromJson(Map<String, dynamic> json) =>
      AssistantAppLinks(
        name: readStringSafe(json, 'name'),
        icon: readStringSafe(json, 'iconUrl'),
        home: readStringSafe(json, 'home'),
        ios: readStringSafe(json, 'ios'),
        android: readStringSafe(json, 'android'),
        web: readStringSafe(json, 'web'),
      );
}
