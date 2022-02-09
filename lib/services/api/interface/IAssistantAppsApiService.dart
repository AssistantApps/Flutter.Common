import '../../../contracts/generated/translationVoteViewModel.dart';
import '../../../contracts/results/paginationResultWithValue.dart';

class IAssistantAppsApiService {
  //
  Future<PaginationResultWithValue<List<TranslationVoteViewModel>>>
      getTranslators() async {
    return PaginationResultWithValue<List<TranslationVoteViewModel>>(
        false, List.empty(growable: true), 1, 0, '');
  }
}
