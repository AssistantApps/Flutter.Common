// To parse this JSON data, do
//
//     final patreonOAuthResponseViewModel = patreonOAuthResponseViewModelFromJson(jsonString);

import 'dart:convert';

import 'package:assistantapps_flutter_common/helpers/jsonHelper.dart';

class PatreonOAuthResponseViewModel {
  PatreonOAuthResponseViewModel({
    this.loginFailed,
    this.belongsToAssistantAppsCampaign,
    this.errorMessage,
  });

  bool loginFailed;
  bool belongsToAssistantAppsCampaign;
  String errorMessage;

  factory PatreonOAuthResponseViewModel.fromRawJson(String str) =>
      PatreonOAuthResponseViewModel.fromJson(json.decode(str));

  factory PatreonOAuthResponseViewModel.fromJson(Map<String, dynamic> json) =>
      PatreonOAuthResponseViewModel(
        loginFailed: readBoolSafe(json, 'loginFailed'),
        belongsToAssistantAppsCampaign:
            readBoolSafe(json, 'belongsToAssistantAppsCampaign'),
        errorMessage: readStringSafe(json, 'errorMessage'),
      );
}
