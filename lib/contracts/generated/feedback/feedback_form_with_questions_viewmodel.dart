import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'feedback_form_question_viewmodel.dart';

class FeedbackFormWithQuestionsViewModel {
  final String guid;
  final String appGuid;
  final String title;
  final String text;
  final DateTime dateCreated;
  final List<FeedbackFormQuestionViewModel> items;

  FeedbackFormWithQuestionsViewModel({
    required this.items,
    required this.guid,
    required this.appGuid,
    required this.title,
    required this.text,
    required this.dateCreated,
  });

  factory FeedbackFormWithQuestionsViewModel.fromRawJson(String str) =>
      FeedbackFormWithQuestionsViewModel.fromJson(json.decode(str));

  factory FeedbackFormWithQuestionsViewModel.fromJson(
          Map<String, dynamic> json) =>
      FeedbackFormWithQuestionsViewModel(
        guid: readStringSafe(json, 'guid'),
        appGuid: readStringSafe(json, 'appGuid'),
        title: readStringSafe(json, 'title'),
        text: readStringSafe(json, 'text'),
        dateCreated: readDateSafe(json, 'dateCreated'),
        items: readListSafe(
          json,
          'items',
          (x) => FeedbackFormQuestionViewModel.fromJson(x),
        ),
      );
}
