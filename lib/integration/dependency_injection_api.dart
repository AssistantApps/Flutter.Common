import 'package:get_it/get_it.dart';

import '../services/api/assistantAppsApiService.dart';
import '../services/api/donatorApiService.dart';
import '../services/api/guideApiService.dart';
import '../services/api/interface/IAssistantAppsApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IGuideApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/ISteamApiService.dart';
import '../services/api/interface/ITranslationApiService.dart';
import '../services/api/interface/IUserApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/steamApiService.dart';
import '../services/api/translationApiService.dart';
import '../services/api/userApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/authApiService.dart';
import '../services/base/interface/IAuthApiService.dart';
import '../services/signalr/OAuthSignalRService.dart';
import './common_dependency_injection.dart';

void initAssistantAppsDependencyInjectionForApi({
  required IAssistantAppsApiService? assistantAppsApi,
  required IDonatorApiService? donatorApi,
  required IGuideApiService? guideApi,
  required IPatreonApiService? patreonApi,
  required ISteamApiService? steamApi,
  required ITranslationApiService? translationApi,
  required IUserApiService? userApi,
  required IVersionApiService? versionApi,
  required IAuthApiService? assistantAppsAuthApi,
  required OAuthSignalRService? oAuthSignalR,
}) {
  regBackup<IAssistantAppsApiService>(
      assistantAppsApi, AssistantAppsApiService());
  regBackup<IDonatorApiService>(donatorApi, DonatorApiService());
  regBackup<IGuideApiService>(guideApi, GuideApiService());
  regBackup<IPatreonApiService>(patreonApi, PatreonApiService());
  regBackup<ISteamApiService>(steamApi, SteamApiService());
  regBackup<ITranslationApiService>(translationApi, TranslationApiService());
  regBackup<IUserApiService>(userApi, UserApiService());
  regBackup<IVersionApiService>(versionApi, VersionApiService());
  regBackup<IAuthApiService>(assistantAppsAuthApi, AuthApiService());

  // SignalR
  regBackup<OAuthSignalRService>(oAuthSignalR, OAuthSignalRService());
}

IAssistantAppsApiService getAssistantAppsApi() =>
    GetIt.instance<IAssistantAppsApiService>();
IDonatorApiService getAssistantAppsDonators() =>
    GetIt.instance<IDonatorApiService>();
IGuideApiService getAssistantAppsGuide() => GetIt.instance<IGuideApiService>();
IPatreonApiService getAssistantAppsPatreons() =>
    GetIt.instance<IPatreonApiService>();
ISteamApiService getAssistantAppsSteam() => GetIt.instance<ISteamApiService>();
ITranslationApiService getAssistantAppsTranslation() =>
    GetIt.instance<ITranslationApiService>();
IVersionApiService getAssistantAppsVersions() =>
    GetIt.instance<IVersionApiService>();
IUserApiService getAssistantAppsUserApi() => GetIt.instance<IUserApiService>();
IAuthApiService getAssistantAppsAuthApi() => GetIt.instance<IAuthApiService>();

// AssistantApps SignalR
OAuthSignalRService getAssistantAppsOAuthSignalR() =>
    GetIt.instance<OAuthSignalRService>();
