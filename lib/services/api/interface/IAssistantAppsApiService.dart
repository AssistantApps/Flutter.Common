import '../../../contracts/generated/appNoticeViewModel.dart';
import '../../../contracts/generated/translatorLeaderboardItemViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/resultWithValue.dart';

class IAssistantAppsApiService {
  //
  Future<PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>>
      getTranslators() async {
    return PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }

  Future<ResultWithValue<List<AppNoticeViewModel>>> getAppNotices(
      String langCode) async {
    return ResultWithValue<List<AppNoticeViewModel>>(
        false, List.empty(growable: true), '');
  }
}
