// To parse this JSON data, do
//
//     final translationVoteViewModel = translationVoteViewModelFromMap(jsonString);

import 'dart:convert';

import '../../assistantapps_flutter_common.dart';

class TranslatorLeaderboardItemViewModel {
  TranslatorLeaderboardItemViewModel({
    this.username,
    this.profileImageUrl,
    this.numTranslations,
    this.numVotes,
    this.total,
  });

  String username;
  String profileImageUrl;
  int numTranslations;
  int numVotes;
  int total;

  factory TranslatorLeaderboardItemViewModel.fromJson(String str) =>
      TranslatorLeaderboardItemViewModel.fromMap(json.decode(str));

  factory TranslatorLeaderboardItemViewModel.fromMap(
          Map<String, dynamic> json) =>
      TranslatorLeaderboardItemViewModel(
        username: readStringSafe(json, "username"),
        profileImageUrl: readStringSafe(json, "profileImageUrl"),
        numTranslations: readIntSafe(json, "numTranslations"),
        numVotes: readIntSafe(json, "numVotes"),
        total: readIntSafe(json, "total"),
      );
}
