import '../../../contracts/generated/app_notice_view_model.dart';
import '../../../contracts/generated/feedback/feedback_form_answer_submission_viewmodel.dart';
import '../../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
import '../../../contracts/generated/translator_leaderboard_item_view_model.dart';
import '../../../contracts/results/paginationResultWithValue.dart';
import '../../../contracts/results/result.dart';
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

  Future<ResultWithValue<FeedbackFormWithQuestionsViewModel>>
      getLatestFeedbackForm() async {
    return ResultWithValue<FeedbackFormWithQuestionsViewModel>(
        false, {} as dynamic, '');
  }

  Future<Result> submitFeedbackFormAnswers(
      FeedbackFormAnswerSubmissionViewModel feedbackAnswers) async {
    return Result(false, '');
  }
}
