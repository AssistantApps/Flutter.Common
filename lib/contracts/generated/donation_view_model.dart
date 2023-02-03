// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);
// https://app.quicktype.io/

import 'dart:convert';

import '../../contracts/enum/donation_type.dart';
import '../../helpers/json_helper.dart';
import 'package:enum_to_string/enum_to_string.dart';

class DonationViewModel {
  String username;
  DonationType type;
  DateTime date;

  DonationViewModel({
    required this.username,
    required this.type,
    required this.date,
  });

  factory DonationViewModel.fromRawJson(String str) =>
      DonationViewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DonationViewModel.fromJson(Map<String, dynamic> json) =>
      DonationViewModel(
        username: readStringSafe(json, 'username'),
        type: EnumToString.fromString(
            DonationType.values, readStringSafe(json, 'type'))!,
        date: readDateSafe(json, 'date'),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "type": type,
        "date": date.toIso8601String(),
      };
}
