library assistantapps_flutter_common;

// Components
export 'components/adaptive/button.dart';
export 'components/adaptive/paginationControl.dart';
export 'components/adaptive/searchBar.dart';
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

// Contracts
export 'contracts/data/assistantAppLinks.dart';
export 'contracts/enum/backgroundType.dart';
export 'contracts/enum/donationType.dart';
export 'contracts/enum/enumBase.dart';
export 'contracts/enum/platformType.dart';
export 'contracts/generated/donationViewModel.dart';
export 'contracts/generated/patreonViewModel.dart';
export 'contracts/generated/versionSearchViewModel.dart';
export 'contracts/generated/versionViewModel.dart';
export 'contracts/results/result.dart';
export 'contracts/results/resultWithValue.dart';
export 'contracts/results/resultWithDoubleValue.dart';
export 'contracts/results/paginationResultWithValue.dart';
export 'contracts/localizationMap.dart';

// Environment
export 'env/assistantAppsEnvironmentSettings.dart';

// Helpers
export 'helpers/dateHelper.dart';
export 'helpers/deviceHelper.dart';
export 'helpers/externalHelper.dart';
export 'helpers/jsonHelper.dart';
export 'helpers/updateHelper.dart';

// Integration
export 'integration/dependencyInjection.dart';
export 'integration/translationDelegate.dart';

// Pages
export 'pages/donators/donatorsPageWidget.dart';
export 'pages/misc/patronListPageWidget.dart';
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
export 'services/base/interface/ITranslationsService.dart';

//Base implementations
export 'services/base/loadingWidgetService.dart';
export 'services/base/loggingService.dart';
export 'services/base/navigationService.dart';
export 'services/base/translationsService.dart';

//Json Interfaces
export 'services/json/interface/IbackupJsonService.dart';

//Json Interfaces
export 'services/json/backupJsonService.dart';
