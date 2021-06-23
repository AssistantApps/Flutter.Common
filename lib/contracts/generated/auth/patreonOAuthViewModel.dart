// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

class PatreonOAuthViewModel {
  String uniqueIdentifier;

  PatreonOAuthViewModel({
    this.uniqueIdentifier,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "uniqueIdentifier": uniqueIdentifier,
      };
}
