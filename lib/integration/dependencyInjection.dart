import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
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
import '../services/base/interface/IAnalyticsService.dart';
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
import 'commonDependencyInjection.dart';
import 'dependencyInjectionApi.dart';
import 'dependencyInjectionBase.dart';

export './dependencyInjectionBase.dart';
export './dependencyInjectionApi.dart';

final getIt = GetIt.instance;

void initAssistantAppsDependencyInjection(
  AssistantAppsEnvironmentSettings _env, {
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
  OAuthSignalRService? oAuthSignalR,

  // Data
  IBackupJsonService? backup,
  IDataJsonService? data,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);

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
  );

  // Data
  regBackup<IBackupJsonService>(backup, BackupJsonService());
  regBackup<IDataJsonService>(data, DataJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    getIt<AssistantAppsEnvironmentSettings>();

// JSON data
IBackupJsonService getAssistantAppsBackup() => getIt<IBackupJsonService>();
IDataJsonService getAssistantAppsData() => getIt<IDataJsonService>();
