import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
import '../services/api/assistantAppsApiService.dart';
import '../services/api/donatorApiService.dart';
import '../services/api/guideApiService.dart';
import '../services/api/interface/IAssistantAppsApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IGuideApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/ITranslationApiService.dart';
import '../services/api/interface/IUserApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/interface/ISteamApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/steamApiService.dart';
import '../services/api/translationApiService.dart';
import '../services/api/userApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/analyticsService.dart';
import '../services/base/baseWidgetService.dart';
import '../services/base/dialogService.dart';
import '../services/base/interface/IAnalyticsService.dart';
import '../services/base/interface/IBaseWidgetService.dart';
import '../services/base/interface/IDialogService.dart';
import '../services/base/interface/ILanguageService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/INavigationService.dart';
import '../services/base/interface/INotificationService.dart';
import '../services/base/interface/IPathService.dart';
import '../services/base/interface/ISnackbarService.dart';
import '../services/base/interface/IThemeService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/interface/IUpdateService.dart';
import '../services/base/languageService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/loggingService.dart';
import '../services/base/navigationService.dart';
import '../services/base/notificationService.dart';
import '../services/base/pathService.dart';
import '../services/base/snackbarService.dart';
import '../services/base/themeService.dart';
import '../services/base/translationsService.dart';
import '../services/base/updateService.dart';
import '../services/json/backupJsonService.dart';
import '../services/json/dataJsonService.dart';
import '../services/json/interface/IbackupJsonService.dart';
import '../services/json/interface/IdataJsonService.dart';
import '../services/signalr/OAuthSignalRService.dart';

final getIt = GetIt.instance;

void initBaseDependencyInjection(
  AssistantAppsEnvironmentSettings _env, {
  // Base
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

  // API
  IAssistantAppsApiService? assistantAppsApi,
  IDonatorApiService? donatorApi,
  IGuideApiService? guideApi,
  IPatreonApiService? patreonApi,
  ISteamApiService? steamApi,
  ITranslationApiService? translationApi,
  IUserApiService? userApi,
  IVersionApiService? versionApi,

  // Data
  IBackupJsonService? backup,
  IDataJsonService? data,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);
  regSingleWithBackup<ILoggerService>(logger, LoggerService());
  regSingleWithBackup<IAnalyticsService>(analytics, AnalyticsService());
  regSingleWithBackup<INavigationService>(navigation, NavigationService());
  regSingleWithBackup<IPathService>(path, PathService());
  regSingleWithBackup<IThemeService>(theme, ThemeService());
  regSingleWithBackup<ILoadingWidgetService>(loading, LoadingWidgetService());
  regSingleWithBackup<IBaseWidgetService>(baseWidget, BaseWidgetService());
  regSingleWithBackup<IDialogService>(dialog, DialogService());
  regSingleWithBackup<ISnackbarService>(snackbar, SnackbarService());
  regSingleWithBackup<IUpdateService>(update, UpdateService());
  regSingleWithBackup<INotificationService>(
      notification, NotificationService());

  regSingleWithBackup<ITranslationService>(translation, TranslationService());
  regSingleWithBackup<ILanguageService>(language, LanguageService());

  // API
  regSingleWithBackup<IAssistantAppsApiService>(
      assistantAppsApi, AssistantAppsApiService());
  regSingleWithBackup<IDonatorApiService>(donatorApi, DonatorApiService());
  regSingleWithBackup<IGuideApiService>(guideApi, GuideApiService());
  regSingleWithBackup<IPatreonApiService>(patreonApi, PatreonApiService());
  regSingleWithBackup<ISteamApiService>(steamApi, SteamApiService());
  regSingleWithBackup<ITranslationApiService>(
      translationApi, TranslationApiService());
  regSingleWithBackup<IUserApiService>(userApi, UserApiService());
  regSingleWithBackup<IVersionApiService>(versionApi, VersionApiService());

  // SignalR
  getIt.registerSingleton<OAuthSignalRService>(OAuthSignalRService());

// Data
  regSingleWithBackup<IBackupJsonService>(backup, BackupJsonService());
  regSingleWithBackup<IDataJsonService>(data, DataJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    getIt<AssistantAppsEnvironmentSettings>();

ILoggerService getLog() => getIt<ILoggerService>();
IAnalyticsService getAnalytics() => getIt<IAnalyticsService>();
INavigationService getNavigation() => getIt<INavigationService>();
IPathService getPath() => getIt<IPathService>();
IThemeService getTheme() => getIt<IThemeService>();
ILoadingWidgetService getLoading() => getIt<ILoadingWidgetService>();
IBaseWidgetService getBaseWidget() => getIt<IBaseWidgetService>();
IDialogService getDialog() => getIt<IDialogService>();
ISnackbarService getSnackbar() => getIt<ISnackbarService>();
IUpdateService getUpdate() => getIt<IUpdateService>();
ITranslationService getTranslations() => getIt<ITranslationService>();
ILanguageService getLanguage() => getIt<ILanguageService>();
INotificationService getNotifications() => getIt<INotificationService>();

// AssistantApps API
IAssistantAppsApiService getAssistantAppsApi() =>
    getIt<IAssistantAppsApiService>();
IDonatorApiService getAssistantAppsDonators() => getIt<IDonatorApiService>();
IGuideApiService getAssistantAppsGuide() => getIt<IGuideApiService>();
IPatreonApiService getAssistantAppsPatreons() => getIt<IPatreonApiService>();
ISteamApiService getAssistantAppsSteam() => getIt<ISteamApiService>();
ITranslationApiService getAssistantAppsTranslation() =>
    getIt<ITranslationApiService>();
IVersionApiService getAssistantAppsVersions() => getIt<IVersionApiService>();
IUserApiService getAssistantAppsUserApi() => getIt<IUserApiService>();

// AssistantApps SignalR
OAuthSignalRService getAssistantAppsOAuthSignalR() =>
    getIt<OAuthSignalRService>();

// JSON data
IBackupJsonService getAssistantAppsBackup() => getIt<IBackupJsonService>();
IDataJsonService getAssistantAppsData() => getIt<IDataJsonService>();

//
// Methods 🔽
//

void regSingleWithBackup<T extends Object>(T? service, T? backupService) {
  if (service != null) {
    getIt.registerSingleton<T>(service);
  } else if (backupService != null) {
    getIt.registerSingleton<T>(backupService);
  }
}
