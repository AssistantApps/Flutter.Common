import 'dart:convert';

class FeedbackFormAnswerViewModel {
  final String feedbackQuestionGuid;
  final String value;

  FeedbackFormAnswerViewModel({
    required this.feedbackQuestionGuid,
    required this.value,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'feedbackQuestionGuid': feedbackQuestionGuid,
        'value': value,
      };
}
