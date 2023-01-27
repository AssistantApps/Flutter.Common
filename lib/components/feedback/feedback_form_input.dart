import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/enum/feedback_question_type.dart';
import '../adaptive/dropdown.dart';

class FeedbackFormInput extends StatelessWidget {
  final FeedbackQuestionType feedbackQuestionType;
  final void Function(String answer) saveAnswer;
  final Size screenMediaQuery;

  const FeedbackFormInput({
    Key? key,
    required this.feedbackQuestionType,
    required this.saveAnswer,
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
            borderRadius: UIConstants.generalBorderRadius,
            borderSide: BorderSide(
              color: darken(getTheme().getPrimaryColour(context), 0.25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: UIConstants.generalBorderRadius,
            borderSide: BorderSide(
              color: getTheme().getPrimaryColour(context),
            ),
          ),
          hintText: 'I think that...', // TODO translate
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        ),
        onChanged: saveAnswer,
      );
    }

    if (feedbackQuestionType == FeedbackQuestionType.FiveStar) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Center(
          child: StarRating(
            currentRating: 0,
            size: 44,
            onTap: (int newValue) => saveAnswer(newValue.toString()),
          ),
        ),
      );
    }

    if (feedbackQuestionType == FeedbackQuestionType.YesNo ||
        feedbackQuestionType == FeedbackQuestionType.YesNoUnknown) {
      List<DropdownOption> options = List.empty(growable: true);
      options.add(DropdownOption(
        getTranslations().fromKey(LocaleKey.yes),
      ));
      if (feedbackQuestionType == FeedbackQuestionType.YesNoUnknown) {
        options.add(DropdownOption(
          getTranslations().fromKey(LocaleKey.unknown),
        ));
      }
      options.add(DropdownOption(
        getTranslations().fromKey(LocaleKey.no),
      ));

      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: AdaptiveDropdown(
          icon: const Icon(Icons.keyboard_arrow_down),
          borderRadius: UIConstants.generalBorderRadius,
          options: options,
          initialValue: options.first.value,
          onChanged: saveAnswer,
        ),
      );
    }

    return const Text('Unknown feedback type');
  }
}
