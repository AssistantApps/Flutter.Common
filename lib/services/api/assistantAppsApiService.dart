import 'dart:convert';

import '../../constants/api_urls.dart';
import '../../contracts/generated/app_notice_view_model.dart';
import '../../contracts/generated/feedback/feedback_form_answer_submission_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
import '../../contracts/generated/translator_leaderboard_item_view_model.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/result.dart';
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
          false,
          List.empty(),
          response.errorMessage,
        );
      }
      final List newsList = json.decode(response.value);
      var news = newsList.map((r) => AppNoticeViewModel.fromJson(r)).toList();
      return ResultWithValue(true, news, '');
    } catch (exception) {
      getLog().e("AppNotices Api Exception: ${exception.toString()}");
      return ResultWithValue<List<AppNoticeViewModel>>(
        false,
        List.empty(),
        exception.toString(),
      );
    }
  }

  @override
  Future<ResultWithValue<FeedbackFormWithQuestionsViewModel>>
      getLatestFeedbackForm() async {
    try {
      final response = await apiGet(
        '${ApiUrls.feedbackLatest}/${getEnv().assistantAppsAppGuid}',
      );
      if (response.hasFailed) {
        return ResultWithValue<FeedbackFormWithQuestionsViewModel>(
          false,
          FeedbackFormWithQuestionsViewModel.fromRawJson('{}'),
          response.errorMessage,
        );
      }
      final FeedbackFormWithQuestionsViewModel feedback =
          FeedbackFormWithQuestionsViewModel.fromRawJson(response.value);
      return ResultWithValue(true, feedback, '');
    } catch (exception) {
      getLog().e("LatestFeedbackForm Api Exception: ${exception.toString()}");
      return ResultWithValue<FeedbackFormWithQuestionsViewModel>(
        false,
        FeedbackFormWithQuestionsViewModel.fromRawJson('{}'),
        exception.toString(),
      );
    }
  }

  @override
  Future<Result> submitFeedbackFormAnswers(
    FeedbackFormAnswerSubmissionViewModel feedbackAnswers,
  ) async {
    try {
      final response = await apiPost(
        ApiUrls.feedbackAnswer,
        feedbackAnswers.toRawJson(),
      );
      if (response.hasFailed) {
        return Result(false, response.errorMessage);
      }

      return Result(true, '');
    } catch (exception) {
      getLog().e(
          "submitFeedbackFormAnswers Api Exception: ${exception.toString()}");
      return Result(false, exception.toString());
    }
  }
}
