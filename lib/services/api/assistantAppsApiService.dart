import 'dart:convert';

import '../../constants/ApiUrls.dart';
import '../../contracts/generated/appNoticeViewModel.dart';
import '../../contracts/generated/translatorLeaderboardItemViewModel.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseApiService.dart';
import './interface/IAssistantAppsApiService.dart';

class AssistantAppsApiService extends BaseApiService
    implements IAssistantAppsApiService {
  AssistantAppsApiService() : super(getEnv().assistantAppsApiUrl);

  @override
  Future<PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>>
      getTranslators() async {
    String url = ApiUrls.translatorLeaderboard;
    try {
      final response = await apiPost(url, json.encode({}));
      if (response.hasFailed) {
        return PaginationResultWithValue<
                List<TranslatorLeaderboardItemViewModel>>(
            false, List.empty(), 1, 0, response.errorMessage);
      }
      PaginationResultWithValue<List<TranslatorLeaderboardItemViewModel>>
          paginationResult = PaginationResultWithValueMapper()
              .fromRawJson<List<TranslatorLeaderboardItemViewModel>>(
                  response.value, (List valueDyn) {
        return valueDyn
            .map((r) => TranslatorLeaderboardItemViewModel.fromMap(r))
            .toList();
      });
      paginationResult.isSuccess = true;
      return paginationResult;
    } catch (exception) {
      getLog().e("Translators Api Exception: ${exception.toString()}");
      return PaginationResultWithValue<
              List<TranslatorLeaderboardItemViewModel>>(
          false, List.empty(), 1, 0, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<List<AppNoticeViewModel>>> getAppNotices(
    String langCode,
  ) async {
    try {
      final response = await apiGet(
        'appNotice/${getEnv().assistantAppsAppGuid}/$langCode',
      );
      if (response.hasFailed) {
        return ResultWithValue<List<AppNoticeViewModel>>(
            false, List.empty(growable: true), response.errorMessage);
      }
      final List newsList = json.decode(response.value);
      var news = newsList.map((r) => AppNoticeViewModel.fromJson(r)).toList();
      return ResultWithValue(true, news, '');
    } catch (exception) {
      getLog().e("AppNotices Api Exception: ${exception.toString()}");
      return ResultWithValue<List<AppNoticeViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
