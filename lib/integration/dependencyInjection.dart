import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
import '../services/api/donatorApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/ITranslationApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/translationApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/analyticsService.dart';
import '../services/base/interface/IAnalyticsService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/INavigationService.dart';
import '../services/base/interface/ISnackbarService.dart';
import '../services/base/interface/IThemeService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/interface/IUpdateService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/loggingService.dart';
import '../services/base/navigationService.dart';
import '../services/base/snackbarService.dart';
import '../services/base/themeService.dart';
import '../services/base/translationsService.dart';
import '../services/base/updateService.dart';
import '../services/json/backupJsonService.dart';
import '../services/json/dataJsonService.dart';
import '../services/json/interface/IbackupJsonService.dart';
import '../services/json/interface/IdataJsonService.dart';

final getIt = GetIt.instance;

initBaseDependencyInjection(
  AssistantAppsEnvironmentSettings _env, {
  ILoggerService logger,
  IAnalyticsService analytics,
  INavigationService navigation,
  IThemeService theme,
  ILoadingWidgetService loading,
  ISnackbarService snackbar,
  IUpdateService update,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);
  registerSingletonWithBackup<ILoggerService>(logger, LoggerService());
  registerSingletonWithBackup<IAnalyticsService>(analytics, AnalyticsService());
  registerSingletonWithBackup<INavigationService>(
      navigation, NavigationService());
  registerSingletonWithBackup<IThemeService>(theme, ThemeService());
  registerSingletonWithBackup<ILoadingWidgetService>(
      loading, LoadingWidgetService());
  registerSingletonWithBackup<ISnackbarService>(snackbar, SnackbarService());
  registerSingletonWithBackup<IUpdateService>(update, UpdateService());

  getIt.registerSingleton<ITranslationService>(TranslationService());

  // API
  getIt.registerSingleton<IDonatorApiService>(DonatorApiService());
  getIt.registerSingleton<IPatreonApiService>(PatreonApiService());
  getIt.registerSingleton<ITranslationApiService>(TranslationApiService());
  getIt.registerSingleton<IVersionApiService>(VersionApiService());

  getIt.registerSingleton<IBackupJsonService>(BackupJsonService());
  getIt.registerSingleton<IDataJsonService>(DataJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    getIt<AssistantAppsEnvironmentSettings>();

ILoggerService getLog() => getIt<ILoggerService>();
IAnalyticsService getAnalytics() => getIt<IAnalyticsService>();
INavigationService getNavigation() => getIt<INavigationService>();
IThemeService getTheme() => getIt<IThemeService>();
ILoadingWidgetService getLoading() => getIt<ILoadingWidgetService>();
ISnackbarService getSnackbar() => getIt<ISnackbarService>();
IUpdateService getUpdate() => getIt<IUpdateService>();
ITranslationService getTranslations() => getIt<ITranslationService>();

// AssistantApps API
IDonatorApiService getAssistantAppsDonators() => getIt<IDonatorApiService>();
IPatreonApiService getAssistantAppsPatreons() => getIt<IPatreonApiService>();
ITranslationApiService getAssistantAppsTranslation() =>
    getIt<ITranslationApiService>();
IVersionApiService getAssistantAppsVersions() => getIt<IVersionApiService>();

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
