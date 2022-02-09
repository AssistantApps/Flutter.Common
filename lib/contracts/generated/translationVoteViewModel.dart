// To parse this JSON data, do
//
//     final translationVoteViewModel = translationVoteViewModelFromMap(jsonString);

import 'dart:convert';

class TranslationVoteViewModel {
  TranslationVoteViewModel({
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

  factory TranslationVoteViewModel.fromJson(String str) =>
      TranslationVoteViewModel.fromMap(json.decode(str));

  factory TranslationVoteViewModel.fromMap(Map<String, dynamic> json) =>
      TranslationVoteViewModel(
        username: json["username"],
        profileImageUrl: json["profileImageUrl"],
        numTranslations: json["numTranslations"],
        numVotes: json["numVotes"],
        total: json["total"],
      );
}
