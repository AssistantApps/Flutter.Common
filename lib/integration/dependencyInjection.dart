import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
import '../services/api/donatorApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/ITranslationApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/interface/IsteamApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/steamApiService.dart';
import '../services/api/translationApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/analyticsService.dart';
import '../services/base/baseWidgetService.dart';
import '../services/base/dialogService.dart';
import '../services/base/interface/IAnalyticsService.dart';
import '../services/base/interface/IBaseWidgetService.dart';
import '../services/base/interface/IDialogService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/INavigationService.dart';
import '../services/base/interface/INotificationService.dart';
import '../services/base/interface/IPathService.dart';
import '../services/base/interface/ISnackbarService.dart';
import '../services/base/interface/IThemeService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/interface/IUpdateService.dart';
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
  ILoggerService logger,
  IAnalyticsService analytics,
  INavigationService navigation,
  IPathService path,
  IThemeService theme,
  ILoadingWidgetService loading,
  IBaseWidgetService baseWidget,
  IDialogService dialog,
  ISnackbarService snackbar,
  IUpdateService update,
  INotificationService notification,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);
  registerSingletonWithBackup<ILoggerService>(logger, LoggerService());
  registerSingletonWithBackup<IAnalyticsService>(analytics, AnalyticsService());
  registerSingletonWithBackup<INavigationService>(
      navigation, NavigationService());
  registerSingletonWithBackup<IPathService>(path, PathService());
  registerSingletonWithBackup<IThemeService>(theme, ThemeService());
  registerSingletonWithBackup<ILoadingWidgetService>(
      loading, LoadingWidgetService());
  registerSingletonWithBackup<IBaseWidgetService>(
      baseWidget, BaseWidgetService());
  registerSingletonWithBackup<IDialogService>(dialog, DialogService());
  registerSingletonWithBackup<ISnackbarService>(snackbar, SnackbarService());
  registerSingletonWithBackup<IUpdateService>(update, UpdateService());
  registerSingletonWithBackup<INotificationService>(
      notification, NotificationService());

  getIt.registerSingleton<ITranslationService>(TranslationService());

  // API
  getIt.registerSingleton<IDonatorApiService>(DonatorApiService());
  getIt.registerSingleton<IPatreonApiService>(PatreonApiService());
  getIt.registerSingleton<ISteamApiService>(SteamApiService());
  getIt.registerSingleton<ITranslationApiService>(TranslationApiService());
  getIt.registerSingleton<IVersionApiService>(VersionApiService());

  // SignalR
  getIt.registerSingleton<OAuthSignalRService>(OAuthSignalRService());

  getIt.registerSingleton<IBackupJsonService>(BackupJsonService());
  getIt.registerSingleton<IDataJsonService>(DataJsonService());
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
INotificationService getNotifications() => getIt<INotificationService>();

// AssistantApps API
IDonatorApiService getAssistantAppsDonators() => getIt<IDonatorApiService>();
IPatreonApiService getAssistantAppsPatreons() => getIt<IPatreonApiService>();
ISteamApiService getAssistantAppsSteam() => getIt<ISteamApiService>();
ITranslationApiService getAssistantAppsTranslation() =>
    getIt<ITranslationApiService>();
IVersionApiService getAssistantAppsVersions() => getIt<IVersionApiService>();

// AssistantApps SignalR
OAuthSignalRService getAssistantAppsOAuthSignalR() =>
    getIt<OAuthSignalRService>();

// JSON data
IBackupJsonService getAssistantAppsBackup() => getIt<IBackupJsonService>();
IDataJsonService getAssistantAppsData() => getIt<IDataJsonService>();

//
// Methods 🔽
//

void registerSingletonWithBackup<T>(T service, T backupService) {
  if (service != null) {
    getIt.registerSingleton<T>(service);
  } else if (backupService != null) {
    getIt.registerSingleton<T>(backupService);
  }
}
