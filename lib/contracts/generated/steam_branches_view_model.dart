// To parse this JSON data, do
//
//     final steamBranchesViewModel = steamBranchesViewModelFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/json_helper.dart';

class SteamBranchesViewModel {
  SteamBranchesViewModel({
    required this.name,
    required this.buildId,
    required this.lastUpdate,
  });

  String name;
  String buildId;
  DateTime lastUpdate;

  factory SteamBranchesViewModel.fromRawJson(String str) =>
      SteamBranchesViewModel.fromJson(json.decode(str));

  factory SteamBranchesViewModel.fromJson(Map<String, dynamic> json) {
    return SteamBranchesViewModel(
      name: readStringSafe(json, 'name'),
      buildId: readStringSafe(json, 'buildId'),
      lastUpdate: readDateSafe(json, 'lastUpdate'),
    );
  }
}
