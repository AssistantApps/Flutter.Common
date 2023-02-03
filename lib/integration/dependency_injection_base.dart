import 'package:get_it/get_it.dart';

import '../repository/local_storage_repository.dart';
import '../repository/secure_storage_repository.dart';
import '../services/base/analytics_service.dart';
import '../services/base/base_widget_service.dart';
import '../services/base/dialog_service.dart';
import '../services/base/interface/i_analytics_service.dart';
import '../services/base/interface/i_base_widget_service.dart';
import '../services/base/interface/i_dialog_service.dart';
import '../services/base/interface/i_language_service.dart';
import '../services/base/interface/i_loading_widget_service.dart';
import '../services/base/interface/i_local_storage_service.dart';
import '../services/base/interface/i_logging_service.dart';
import '../services/base/interface/i_navigation_service.dart';
import '../services/base/interface/i_notification_service.dart';
import '../services/base/interface/i_path_service.dart';
import '../services/base/interface/i_snackbar_service.dart';
import '../services/base/interface/i_theme_service.dart';
import '../services/base/interface/i_translations_service.dart';
import '../services/base/interface/i_update_service.dart';
import '../services/base/language_service.dart';
import '../services/base/loading_widget_service.dart';
import '../services/base/local_storage_service.dart';
import '../services/base/logging_service.dart';
import '../services/base/navigation_service.dart';
import '../services/base/notification_service.dart';
import '../services/base/path_service.dart';
import '../services/base/snackbar_service.dart';
import '../services/base/theme_service.dart';
import '../services/base/translations_service.dart';
import '../services/base/update_service.dart';
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
