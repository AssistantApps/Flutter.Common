// To parse this JSON data, do
//
//     final translationVoteViewModel = translationVoteViewModelFromMap(jsonString);

import 'dart:convert';

import '../../helpers/json_helper.dart';

class TranslatorLeaderboardItemViewModel {
  TranslatorLeaderboardItemViewModel({
    required this.username,
    required this.profileImageUrl,
    required this.numTranslations,
    required this.numVotes,
    required this.total,
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
