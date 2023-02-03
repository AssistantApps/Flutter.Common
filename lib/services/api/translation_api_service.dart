import 'dart:convert';

import '../../constants/api_urls.dart';
import '../../contracts/generated/translation_get_graph_view_model.dart';
import '../../contracts/generated/translations_per_language_graph_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../integration/dependency_injection.dart';
import '../base_api_service.dart';
import './interface/i_translation_api_service.dart';

class TranslationApiService extends BaseApiService
    implements ITranslationApiService {
  TranslationApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>
      getTranslationsPerLanguageChart() async {
    var url = ApiUrls.translationsPerLanguageGraph;
    TranslationGetGraphViewModel data = TranslationGetGraphViewModel(
      appGuidList: [getEnv().assistantAppsAppGuid],
    );
    try {
      final response = await apiPost(url, data.toRawJson());
      if (response.hasFailed) {
        return ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>(
            false, List.empty(growable: true), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var chartData = newsList
          .map((r) => TranslationsPerLanguageGraphViewModel.fromJson(r))
          .toList();
      return ResultWithValue(true, chartData, '');
    } catch (exception) {
      getLog().e(
          "getTranslationsPerLanguageChart Api Exception: ${exception.toString()}");
      return ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
