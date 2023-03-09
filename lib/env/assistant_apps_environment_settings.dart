class AssistantAppsEnvironmentSettings {
  bool isProduction;
  String assistantAppsApiUrl;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;
  String patreonOAuthClientId;

  String? buildName;
  String? buildNum;
  String? commitHash;
  String? githubViewAppRepoAtCommit;

  int? appVersionBuildNumberOverride;
  String? appVersionBuildNameOverride;

  AssistantAppsEnvironmentSettings({
    this.isProduction = true,
    this.assistantAppsApiUrl = 'https://api.assistantapps.com',
    required this.assistantAppsAppGuid,
    required this.currentWhatIsNewGuid,
    required this.patreonOAuthClientId,

    // Settings page debug info
    this.buildName,
    this.buildNum,
    this.commitHash,
    this.githubViewAppRepoAtCommit,

    // Version fixes
    this.appVersionBuildNumberOverride,
    this.appVersionBuildNameOverride,
  });
}
