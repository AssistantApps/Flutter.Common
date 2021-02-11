// To parse this JSON data, do
//
//     final steamBranchesViewModel = steamBranchesViewModelFromMap(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

class SteamBranchesViewModel {
  SteamBranchesViewModel({
    this.name,
    this.buildId,
    this.lastUpdate,
  });

  String name;
  String buildId;
  DateTime lastUpdate;

  factory SteamBranchesViewModel.fromRawJson(String str) =>
      SteamBranchesViewModel.fromJson(json.decode(str));

  factory SteamBranchesViewModel.fromJson(Map<String, dynamic> json) =>
      SteamBranchesViewModel(
        name: readStringSafe(json, 'name'),
        buildId: readStringSafe(json, 'buildId'),
        lastUpdate: readDateSafe(json, 'lastUpdate'),
      );
}
