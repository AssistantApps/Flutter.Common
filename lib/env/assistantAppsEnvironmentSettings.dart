import 'package:flutter/material.dart';

class AssistantAppsEnvironmentSettings {
  bool isProduction;
  String assistantAppsApiUrl;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;
  String patreonOAuthClientId;
  String patreonOAuthRedirectUrl;

  AssistantAppsEnvironmentSettings({
    this.isProduction = true,
    this.assistantAppsApiUrl = 'https://api.assistantapps.com',
    @required this.assistantAppsAppGuid,
    @required this.currentWhatIsNewGuid,
    @required this.patreonOAuthClientId,
    @required this.patreonOAuthRedirectUrl,
  });
}
