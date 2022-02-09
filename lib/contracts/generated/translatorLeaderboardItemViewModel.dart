// To parse this JSON data, do
//
//     final translationVoteViewModel = translationVoteViewModelFromMap(jsonString);

import 'dart:convert';

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
        username: json["username"],
        profileImageUrl: json["profileImageUrl"],
        numTranslations: json["numTranslations"],
        numVotes: json["numVotes"],
        total: json["total"],
      );
}
