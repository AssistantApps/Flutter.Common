import '../../../contracts/generated/translations_per_language_graph_view_model.dart';
import '../../../contracts/results/resultWithValue.dart';

class ITranslationApiService {
  Future<ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>>
      getTranslationsPerLanguageChart() async {
    return ResultWithValue<List<TranslationsPerLanguageGraphViewModel>>(
        false, List.empty(growable: true), 'Not Implemented');
  }
}
