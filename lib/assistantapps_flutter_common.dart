library assistantapps_flutter_common;

//Contracts
export 'contracts/results/result.dart';
export 'contracts/results/resultWithValue.dart';
export 'contracts/results/resultWithDoubleValue.dart';
export 'contracts/results/paginationResultWithValue.dart';

//Pages
export 'pages/donators/donatorsPage.dart';
export 'pages/misc/patronListPage.dart';
export 'pages/whatIsNew/whatIsNewPage.dart';
export 'pages/whatIsNew/whatIsNewDetailPage.dart';

//Services

//Api Interfaces
export 'services/api/interface/IdonatorApiService.dart';
export 'services/api/interface/IpatreonApiService.dart';
export 'services/api/interface/IversionApiService.dart';

//Api implementations
export 'services/api/donatorApiService.dart';
export 'services/api/patreonApiService.dart';
export 'services/api/versionApiService.dart';

//Json Interfaces
export 'services/json/interface/IbackupJsonService.dart';

//Json Interfaces
export 'services/json/backupJsonService.dart';
