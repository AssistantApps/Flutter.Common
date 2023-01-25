import 'package:flutter/material.dart';

import '../../contracts/enum/feedback_question_type.dart';
import '../../helpers/colourHelper.dart';
import '../../integration/dependencyInjectionBase.dart';
import '../forms/starRating.dart';

class FeedbackFormInput extends StatelessWidget {
  final FeedbackQuestionType feedbackQuestionType;
  final Size screenMediaQuery;

  const FeedbackFormInput({
    Key? key,
    required this.feedbackQuestionType,
    required this.screenMediaQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (feedbackQuestionType == FeedbackQuestionType.PlainText) {
      return TextField(
        keyboardType: TextInputType.multiline,
        minLines: screenMediaQuery.height > 400 ? 2 : 1,
        maxLines: 12,
        maxLength: 500,
        cursorColor: getTheme().getPrimaryColour(context),
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: darken(getTheme().getPrimaryColour(context), 0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: getTheme().getPrimaryColour(context),
            ),
          ),
          hintText: 'I think that...', // TODO translate
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        ),
      );
    }

    if (feedbackQuestionType == FeedbackQuestionType.FiveStar) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: StarRating(
          currentRating: 0,
          onTap: (int newValue) {
            //
          },
        ),
      );
    }

    return const Text('Unknown feedback type');
  }
}
