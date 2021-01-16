library assistantapps_flutter_common;

// Components
export 'components/adaptive/bottomModal.dart';
export 'components/adaptive/button.dart';
export 'components/adaptive/checkbox.dart';
export 'components/adaptive/paginationControl.dart';
export 'components/adaptive/searchBar.dart';
export 'components/adaptive/segmentedControl.dart';
export 'components/common/card.dart';
export 'components/common/image.dart';
export 'components/common/newBanner.dart';
export 'components/common/space.dart';
export 'components/common/text.dart';
export 'components/fun/backgroundWrapper.dart';
export 'components/list/lazyLoadedSearchableList.dart';
export 'components/list/listWithScrollbar.dart';
export 'components/list/searchableList.dart';
export 'components/menu/popupMenu.dart';
export 'components/modalBottomSheet/assistantAppsModalBottomSheet.dart';

// Constants
export 'constants/ExternalUrls.dart';
export 'constants/SupportedLanguages.dart';
export 'constants/UIConstants.dart';

// Contracts
export 'contracts/data/assistantAppLinks.dart';
export 'contracts/enum/backgroundType.dart';
export 'contracts/enum/donationType.dart';
export 'contracts/enum/enumBase.dart';
export 'contracts/enum/localeKey.dart';
export 'contracts/enum/platformType.dart';
export 'contracts/generated/donationViewModel.dart';
export 'contracts/generated/patreonViewModel.dart';
export 'contracts/generated/versionSearchViewModel.dart';
export 'contracts/generated/versionViewModel.dart';
export 'contracts/misc/popupMenuActionItem.dart';
export 'contracts/results/result.dart';
export 'contracts/results/resultWithValue.dart';
export 'contracts/results/resultWithDoubleValue.dart';
export 'contracts/results/paginationResultWithValue.dart';
export 'contracts/localizationMap.dart';

// Environment
export 'env/assistantAppsEnvironmentSettings.dart';

// Helpers
export 'helpers/colourHelper.dart';
export 'helpers/dateHelper.dart';
export 'helpers/deviceHelper.dart';
export 'helpers/externalHelper.dart';
export 'helpers/jsonHelper.dart';
export 'helpers/stringHelper.dart';
export 'helpers/updateHelper.dart';

// Integration
export 'integration/dependencyInjection.dart' hide getEnv;
export 'integration/translationDelegate.dart';

// Pages
export 'pages/donators/donatorsPageWidget.dart';
export 'pages/patrons/patronListPageWidget.dart';
export 'pages/whatIsNew/whatIsNewPageWidget.dart';
export 'pages/whatIsNew/whatIsNewDetailPageWidget.dart';

//Services

//Api Interfaces
export 'services/api/interface/IDonatorApiService.dart';
export 'services/api/interface/IPatreonApiService.dart';
export 'services/api/interface/IVersionApiService.dart';

//Api implementations
export 'services/api/donatorApiService.dart';
export 'services/api/patreonApiService.dart';
export 'services/api/versionApiService.dart';

//Base Interfaces
export 'services/base/interface/ILoadingWidgetService.dart';
export 'services/base/interface/ILoggingService.dart';
export 'services/base/interface/INavigationService.dart';
export 'services/base/interface/IThemeService.dart';
export 'services/base/interface/ITranslationsService.dart';

//Base implementations
export 'services/base/loadingWidgetService.dart';
export 'services/base/loggingService.dart';
export 'services/base/navigationService.dart';
export 'services/base/themeService.dart';
export 'services/base/translationsService.dart';

//Json Interfaces
export 'services/json/interface/IbackupJsonService.dart';

//Json Interfaces
export 'services/json/backupJsonService.dart';
