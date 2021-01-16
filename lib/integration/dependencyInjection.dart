import 'package:assistantapps_flutter_common/services/base/interface/IThemeService.dart';
import 'package:assistantapps_flutter_common/services/base/themeService.dart';
import 'package:get_it/get_it.dart';

import '../env/assistantAppsEnvironmentSettings.dart';
// Api Services
import '../services/api/donatorApiService.dart';
import '../services/api/interface/IDonatorApiService.dart';
import '../services/api/interface/IPatreonApiService.dart';
import '../services/api/interface/IVersionApiService.dart';
import '../services/api/patreonApiService.dart';
import '../services/api/versionApiService.dart';
import '../services/base/interface/ILoadingWidgetService.dart';
import '../services/base/interface/ILoggingService.dart';
import '../services/base/interface/ITranslationsService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/loggingService.dart';
import '../services/base/translationsService.dart';
import '../services/json/backupJsonService.dart';
import '../services/json/interface/IbackupJsonService.dart';

final getIt = GetIt.instance;

initBaseDependencyInjection(
  AssistantAppsEnvironmentSettings _env, {
  ILoggerService logger,
  IThemeService theme,
}) {
  getIt.registerSingleton<AssistantAppsEnvironmentSettings>(_env);
  registerSingletonWithBackup<ILoggerService>(logger, LoggerService());
  registerSingletonWithBackup<IThemeService>(theme, ThemeService());

  getIt.registerSingleton<ITranslationService>(TranslationService());
  getIt.registerSingleton<ILoadingWidgetService>(LoadingWidgetService());

  // AssistantApps API
  getIt.registerSingleton<IDonatorApiService>(DonatorApiService());
  getIt.registerSingleton<IPatreonApiService>(PatreonApiService());
  getIt.registerSingleton<IVersionApiService>(VersionApiService());
  getIt.registerSingleton<IBackupJsonService>(BackupJsonService());
}

AssistantAppsEnvironmentSettings getEnv() =>
    getIt<AssistantAppsEnvironmentSettings>();

ILoggerService getLog() => getIt<ILoggerService>();
ILoadingWidgetService getLoading() => getIt<ILoadingWidgetService>();
IThemeService getTheme() => getIt<IThemeService>();
// ignore: non_constant_identifier_names
ITranslationService get Translations => getIt<ITranslationService>();

// AssistantApps
IDonatorApiService getAssistantAppsDonators() => getIt<IDonatorApiService>();
IPatreonApiService getAssistantAppsPatreons() => getIt<IPatreonApiService>();
IVersionApiService getAssistantAppsVersions() => getIt<IVersionApiService>();
IBackupJsonService getAssistantAppsBackup() => getIt<IBackupJsonService>();

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
