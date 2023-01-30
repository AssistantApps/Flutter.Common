import 'dart:convert';

import 'feedback_form_answer_viewmodel.dart';

class FeedbackFormAnswerSubmissionViewModel {
  final String feedbackFormGuid;
  final String userUniqueIdentifier;
  final String platformType;
  final List<FeedbackFormAnswerViewModel> items;

  FeedbackFormAnswerSubmissionViewModel({
    required this.feedbackFormGuid,
    required this.userUniqueIdentifier,
    required this.platformType,
    required this.items,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'feedbackFormGuid': feedbackFormGuid,
        'userUniqueIdentifier': userUniqueIdentifier,
        'platformType': platformType,
        'items': items,
      };
}
