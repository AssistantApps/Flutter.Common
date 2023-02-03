import 'package:get_it/get_it.dart';

import '../repository/localStorageRepository.dart';
import '../repository/secureStorageRepository.dart';
import '../services/base/analyticsService.dart';
import '../services/base/baseWidgetService.dart';
import '../services/base/dialogService.dart';
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
import '../services/base/languageService.dart';
import '../services/base/loadingWidgetService.dart';
import '../services/base/localStorageService.dart';
import '../services/base/loggingService.dart';
import '../services/base/navigationService.dart';
import '../services/base/notificationService.dart';
import '../services/base/pathService.dart';
import '../services/base/snackbarService.dart';
import '../services/base/themeService.dart';
import '../services/base/translationsService.dart';
import '../services/base/updateService.dart';
import './common_dependency_injection.dart';

const normalStorageInstanceName = 'normalStorage';
const secureStorageInstanceName = 'secureStorage';

void initAssistantAppsDependencyInjectionForBaseServices({
  required ILoggerService? logger,
  required IAnalyticsService? analytics,
  required INavigationService? navigation,
  required IPathService? path,
  required IThemeService? theme,
  required ILoadingWidgetService? loading,
  required IBaseWidgetService? baseWidget,
  required IDialogService? dialog,
  required ISnackbarService? snackbar,
  required IUpdateService? update,
  required INotificationService? notification,
  required ITranslationService? translation,
  required ILanguageService? language,
  required ILocalStorageService? storage,
  required ILocalStorageService? secureStorage,
}) {
  regBackup<ILoggerService>(logger, LoggerService());
  regBackup<IAnalyticsService>(analytics, AnalyticsService());
  regBackup<INavigationService>(navigation, NavigationService());
  regBackup<IPathService>(path, PathService());
  regBackup<IThemeService>(theme, ThemeService());
  regBackup<ILoadingWidgetService>(loading, LoadingWidgetService());
  regBackup<IBaseWidgetService>(baseWidget, BaseWidgetService());
  regBackup<IDialogService>(dialog, DialogService());
  regBackup<ISnackbarService>(snackbar, SnackbarService());
  regBackup<IUpdateService>(update, UpdateService());
  regBackup<INotificationService>(notification, NotificationService());
  regBackup<ITranslationService>(translation, TranslationService());
  regBackup<ILanguageService>(language, LanguageService());

  regBackup<ILocalStorageService>(
      storage, LocalStorageService(LocalStorageRepository()),
      instanceName: normalStorageInstanceName);
  regBackup<ILocalStorageService>(
      secureStorage, LocalStorageService(SecureStorageRepository()),
      instanceName: secureStorageInstanceName);
}

ILoggerService getLog() => GetIt.instance<ILoggerService>();
IAnalyticsService getAnalytics() => GetIt.instance<IAnalyticsService>();
INavigationService getNavigation() => GetIt.instance<INavigationService>();
IPathService getPath() => GetIt.instance<IPathService>();
IThemeService getTheme() => GetIt.instance<IThemeService>();
ILoadingWidgetService getLoading() => GetIt.instance<ILoadingWidgetService>();
IBaseWidgetService getBaseWidget() => GetIt.instance<IBaseWidgetService>();
IDialogService getDialog() => GetIt.instance<IDialogService>();
ISnackbarService getSnackbar() => GetIt.instance<ISnackbarService>();
IUpdateService getUpdate() => GetIt.instance<IUpdateService>();
ITranslationService getTranslations() => GetIt.instance<ITranslationService>();
ILanguageService getLanguage() => GetIt.instance<ILanguageService>();
INotificationService getNotifications() =>
    GetIt.instance<INotificationService>();

ILocalStorageService getStorageRepo() => GetIt.instance<ILocalStorageService>(
      instanceName: normalStorageInstanceName,
    );
ILocalStorageService getSecureStorageRepo() =>
    GetIt.instance<ILocalStorageService>(
      instanceName: secureStorageInstanceName,
    );
