import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
import '../services/api/donatorApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/INavigationService.dart';
import '../services/base/interface/IThemeService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/loggingService.dart';
import '../services/base/navigationService.dart';
import '../services/base/themeService.dart';
import '../services/base/translationsService.dart';
import '../services/json/backupJsonService.dart';
import '../services/json/dataJsonService.dart';
import '../services/json/interface/IbackupJsonService.dart';
import '../services/json/interface/IdataJsonService.dart';

final getIt = GetIt.instance;

initBaseDependencyInjection(
  AssistantAppsEnvironmentSettings _env, {
  ILoggerService logger,
  IThemeService theme,
  INavigationService navigation,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);
  registerSingletonWithBackup<ILoggerService>(logger, LoggerService());
  registerSingletonWithBackup<IThemeService>(theme, ThemeService());
  registerSingletonWithBackup<INavigationService>(
      navigation, NavigationService());

  getIt.registerSingleton<ITranslationService>(TranslationService());
  getIt.registerSingleton<ILoadingWidgetService>(LoadingWidgetService());

  // API
  getIt.registerSingleton<IDonatorApiService>(DonatorApiService());
  getIt.registerSingleton<IPatreonApiService>(PatreonApiService());
  getIt.registerSingleton<IVersionApiService>(VersionApiService());

  getIt.registerSingleton<IBackupJsonService>(BackupJsonService());
  getIt.registerSingleton<IDataJsonService>(DataJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    getIt<AssistantAppsEnvironmentSettings>();

ILoggerService getLog() => getIt<ILoggerService>();
ILoadingWidgetService getLoading() => getIt<ILoadingWidgetService>();
IThemeService getTheme() => getIt<IThemeService>();
INavigationService getNavigation() => getIt<INavigationService>();
// ignore: non_constant_identifier_names
ITranslationService get Translations => getIt<ITranslationService>();

// AssistantApps API
IDonatorApiService getAssistantAppsDonators() => getIt<IDonatorApiService>();
IPatreonApiService getAssistantAppsPatreons() => getIt<IPatreonApiService>();
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
