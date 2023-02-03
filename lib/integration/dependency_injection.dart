import 'package:get_it/get_it.dart';

import '../env/assistant_apps_environment_settings.dart';
import '../services/api/interface/i_assistant_apps_api_service.dart';
import '../services/api/interface/i_donator_api_service.dart';
import '../services/api/interface/i_guide_api_service.dart';
import '../services/api/interface/i_patreon_api_service.dart';
import '../services/api/interface/i_steam_api_service.dart';
import '../services/api/interface/i_translation_api_service.dart';
import '../services/api/interface/i_user_api_service.dart';
import '../services/api/interface/i_version_api_service.dart';
import '../services/base/interface/IAnalyticsService.dart';
import '../services/base/interface/IAuthApiService.dart';
import '../services/base/interface/IBaseWidgetService.dart';
import '../services/base/interface/IDialogService.dart';
import '../services/base/interface/ILanguageService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILocalStorageService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/INavigationService.dart';
import '../services/base/interface/INotificationService.dart';
import '../services/base/interface/IPathService.dart';
import '../services/base/interface/ISnackbarService.dart';
import '../services/base/interface/IThemeService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/interface/IUpdateService.dart';
import '../services/json/backupJsonService.dart';
import '../services/json/dataJsonService.dart';
import '../services/json/interface/IbackupJsonService.dart';
import '../services/json/interface/IdataJsonService.dart';
import '../services/signalr/OAuthSignalRService.dart';
import './common_dependency_injection.dart';
import './dependency_injection_api.dart';
import './dependency_injection_base.dart';

export './dependency_injection_api.dart';
export './dependency_injection_base.dart';

void initAssistantAppsDependencyInjection(
  AssistantAppsEnvironmentSettings env, {
  // Base Services
  ILoggerService? logger,
  IAnalyticsService? analytics,
  INavigationService? navigation,
  IPathService? path,
  IThemeService? theme,
  ILoadingWidgetService? loading,
  IBaseWidgetService? baseWidget,
  IDialogService? dialog,
  ISnackbarService? snackbar,
  IUpdateService? update,
  INotificationService? notification,
  ITranslationService? translation,
  ILanguageService? language,
  ILocalStorageService? storage,
  ILocalStorageService? secureStorage,

  // API
  IAssistantAppsApiService? assistantAppsApi,
  IDonatorApiService? donatorApi,
  IGuideApiService? guideApi,
  IPatreonApiService? patreonApi,
  ISteamApiService? steamApi,
  ITranslationApiService? translationApi,
  IUserApiService? userApi,
  IVersionApiService? versionApi,
  IAuthApiService? assistantAppsAuthApi,
  OAuthSignalRService? oAuthSignalR,

  // Data
  IBackupJsonService? backup,
  IDataJsonService? data,
}) {
  GetIt.instance.registerSingleton<AssistantAppsEnvironmentSettings>(env);

  // Base
  initAssistantAppsDependencyInjectionForBaseServices(
    logger: logger,
    analytics: analytics,
    navigation: navigation,
    path: path,
    theme: theme,
    loading: loading,
    baseWidget: baseWidget,
    dialog: dialog,
    snackbar: snackbar,
    update: update,
    notification: notification,
    translation: translation,
    language: language,
    storage: storage,
    secureStorage: secureStorage,
  );

  initAssistantAppsDependencyInjectionForApi(
    assistantAppsApi: assistantAppsApi,
    donatorApi: donatorApi,
    guideApi: guideApi,
    patreonApi: patreonApi,
    steamApi: steamApi,
    translationApi: translationApi,
    userApi: userApi,
    versionApi: versionApi,
    oAuthSignalR: oAuthSignalR,
    assistantAppsAuthApi: assistantAppsAuthApi,
  );

  // Data
  regBackup<IBackupJsonService>(backup, BackupJsonService());
  regBackup<IDataJsonService>(data, DataJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    GetIt.instance<AssistantAppsEnvironmentSettings>();

// JSON data
IBackupJsonService getAssistantAppsBackup() =>
    GetIt.instance<IBackupJsonService>();
IDataJsonService getAssistantAppsData() => GetIt.instance<IDataJsonService>();
