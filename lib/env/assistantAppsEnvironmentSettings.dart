class AssistantAppsEnvironmentSettings {
  bool isProduction;
  String assistantAppsApiUrl;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;
  String patreonOAuthClientId;
  int? appVersionBuildNumberOverride;
  int? appVersionBuildNameOverride;

  AssistantAppsEnvironmentSettings({
    this.isProduction = true,
    this.assistantAppsApiUrl = 'https://api.assistantapps.com',
    required this.assistantAppsAppGuid,
    required this.currentWhatIsNewGuid,
    required this.patreonOAuthClientId,
    this.appVersionBuildNumberOverride,
    this.appVersionBuildNameOverride,
  });
}
