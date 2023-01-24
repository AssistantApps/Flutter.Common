import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../enum/feedback_question_type.dart';

class FeedbackFormQuestionViewModel {
  final String guid;
  final String feedbackFormGuid;
  final String questionText;
  final FeedbackQuestionType questionType;
  final bool answerCanContainSensitiveInfo;
  final int sortOrder;

  FeedbackFormQuestionViewModel({
    required this.guid,
    required this.feedbackFormGuid,
    required this.questionText,
    required this.questionType,
    required this.answerCanContainSensitiveInfo,
    required this.sortOrder,
  });

  factory FeedbackFormQuestionViewModel.fromRawJson(String str) =>
      FeedbackFormQuestionViewModel.fromJson(json.decode(str));

  factory FeedbackFormQuestionViewModel.fromJson(Map<String, dynamic> json) =>
      FeedbackFormQuestionViewModel(
        guid: readStringSafe(json, 'guid'),
        feedbackFormGuid: readStringSafe(json, 'feedbackFormGuid'),
        questionText: readStringSafe(json, 'questionText'),
        questionType: FeedbackQuestionType.values[readIntSafe(
          json,
          'questionType',
        )],
        answerCanContainSensitiveInfo: readBoolSafe(
          json,
          'answerCanContainSensitiveInfo',
        ),
        sortOrder: readIntSafe(json, 'sortOrder'),
      );
}
