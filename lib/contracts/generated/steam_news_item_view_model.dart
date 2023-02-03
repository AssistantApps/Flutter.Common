// To parse this JSON data, do
//
//     final steamNewsItem = steamNewsItemFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/json_helper.dart';

class SteamNewsItemViewModel {
  SteamNewsItemViewModel({
    required this.name,
    required this.date,
    required this.link,
    required this.image,
    required this.shortDescription,
    required this.videoLink,
    required this.upVotes,
    required this.downVotes,
    required this.commentCount,
  });

  String name;
  DateTime date;
  String link;
  String image;
  String shortDescription;
  String videoLink;
  int upVotes;
  int downVotes;
  int commentCount;

  factory SteamNewsItemViewModel.fromRawJson(String str) =>
      SteamNewsItemViewModel.fromJson(json.decode(str));

  factory SteamNewsItemViewModel.fromJson(Map<String, dynamic> json) =>
      SteamNewsItemViewModel(
        name: readStringSafe(json, 'name'),
        date: readDateSafe(json, 'date'),
        link: readStringSafe(json, 'link'),
        image: readStringSafe(json, 'image'),
        shortDescription: readStringSafe(json, 'shortDescription'),
        videoLink: readStringSafe(json, 'videoLink'),
        upVotes: readIntSafe(json, 'upVotes'),
        downVotes: readIntSafe(json, 'downVotes'),
        commentCount: readIntSafe(json, 'commentCount'),
      );
}
