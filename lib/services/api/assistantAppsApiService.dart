import '../../constants/ApiUrls.dart';
import '../../contracts/generated/translationVoteViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import 'interface/IAssistantAppsApiService.dart';

class AssistantAppsApiService extends BaseApiService
    implements IAssistantAppsApiService {
  AssistantAppsApiService() : super(getEnv().assistantAppsApiUrl);

  Future<PaginationResultWithValue<List<TranslationVoteViewModel>>>
      getTranslators() async {
    String url = '${ApiUrls.translatorLeaderboard}';
    try {
      final response = await this.apiPost(url, {});
      if (response.hasFailed) {
        return PaginationResultWithValue<List<TranslationVoteViewModel>>(
            false, List.empty(growable: true), 1, 0, response.errorMessage);
      }
      PaginationResultWithValue<List<TranslationVoteViewModel>>
          paginationResult = PaginationResultWithValueMapper()
              .fromRawJson<List<TranslationVoteViewModel>>(response.value,
                  (List valueDyn) {
        return valueDyn
            .map((r) => TranslationVoteViewModel.fromJson(r))
            .toList();
      });
      return paginationResult;
    } catch (exception) {
      getLog().e("Translators Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<List<TranslationVoteViewModel>>(
          false, List.empty(), 1, 0, exception.toString());
    }
  }
}
