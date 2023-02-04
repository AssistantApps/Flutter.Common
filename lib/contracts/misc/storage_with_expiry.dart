import 'dart:convert';

import '../../helpers/json_helper.dart';

class StorageWithExpiry {
  final String data;
  final DateTime expiryDateTime;

  StorageWithExpiry({
    required this.data,
    required this.expiryDateTime,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "data": data,
        "expiryDateTime": expiryDateTime.toIso8601String(),
      };

  factory StorageWithExpiry.fromRawJson(String str) =>
      StorageWithExpiry.fromJson(json.decode(str));

  factory StorageWithExpiry.fromJson(Map<String, dynamic> json) =>
      StorageWithExpiry(
        data: readStringSafe(json, 'data'),
        expiryDateTime: readDateSafe(json, 'expiryDateTime'),
      );
}
