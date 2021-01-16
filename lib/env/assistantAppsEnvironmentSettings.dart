import 'package:flutter/material.dart';

class AssistantAppsEnvironmentSettings {
  bool isProduction;
  String assistantAppsApiUrl;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;

  AssistantAppsEnvironmentSettings({
    this.isProduction = true,
    this.assistantAppsApiUrl = 'https://api.assistantapps.com',
    @required this.assistantAppsAppGuid,
    @required this.currentWhatIsNewGuid,
  });
}
