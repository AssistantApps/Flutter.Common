import '../../../contracts/generated/translatorLeaderboardItemViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';

class IAssistantAppsApiService {
  //
  Future<PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>>
      getTranslators() async {
    return PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }
}
