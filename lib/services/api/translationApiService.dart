import 'dart:convert';

import '../../constants/api_urls.dart';
import '../../contracts/generated/translationGetGraphViewModel.dart';
import '../../contracts/generated/translationsPerLanguageGraphViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import './interface/ITranslationApiService.dart';

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
