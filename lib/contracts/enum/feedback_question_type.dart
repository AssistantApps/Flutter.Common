// ignore_for_file: constant_identifier_names

import 'enumBase.dart';

enum FeedbackQuestionType {
  PlainText,
  YesNo,
  YesNoUnknown,
  FiveStar,
}

final feedbackQuestionTypeValues = EnumValues({
  "0": FeedbackQuestionType.PlainText,
  "1": FeedbackQuestionType.YesNo,
  "2": FeedbackQuestionType.YesNoUnknown,
  "3": FeedbackQuestionType.FiveStar,
});
