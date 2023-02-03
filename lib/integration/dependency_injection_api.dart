import 'package:get_it/get_it.dart';

import '../services/api/assistant_apps_api_service.dart';
import '../services/api/donator_api_service.dart';
import '../services/api/guide_api_service.dart';
import '../services/api/interface/i_assistant_apps_api_service.dart';
import '../services/api/interface/i_donator_api_service.dart';
import '../services/api/interface/i_guide_api_service.dart';
import '../services/api/interface/i_patreon_api_service.dart';
import '../services/api/interface/i_steam_api_service.dart';
import '../services/api/interface/i_translation_api_service.dart';
import '../services/api/interface/i_user_api_service.dart';
import '../services/api/interface/i_version_api_service.dart';
import '../services/api/patreon_api_service.dart';
import '../services/api/steam_api_service.dart';
import '../services/api/translation_api_service.dart';
import '../services/api/user_api_service.dart';
import '../services/api/version_api_service.dart';
import '../services/base/auth_api_service.dart';
import '../services/base/interface/i_auth_api_service.dart';
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
