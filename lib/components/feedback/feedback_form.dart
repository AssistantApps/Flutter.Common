import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/enum/networkState.dart';
import '../../contracts/generated/feedback/feedback_form_question_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/colourHelper.dart';
import '../../integration/dependencyInjectionApi.dart';
import '../../integration/dependencyInjectionBase.dart';
import '../adaptive/button.dart';
import '../common/space.dart';
import '../common/text.dart';
import 'feedback_animation_state.dart';
import 'feedback_form_header.dart';
import 'feedback_services.dart';

class FeedbackForm extends StatefulWidget {
  final FeedbackServices feedbackServices;

  const FeedbackForm({
    Key? key,
    required this.feedbackServices,
  }) : super(key: key);

  @override
  createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm>
    with AfterLayoutMixin<FeedbackForm>, TickerProviderStateMixin {
  NetworkState networkState = NetworkState.Loading;
  List<FeedbackFormQuestionViewModel> items = List.empty(growable: true);
  int questionIndex = 0;

  @override
  void afterFirstLayout(BuildContext context) => getLatestFeedbackForm(context);

  Future<void> getLatestFeedbackForm(BuildContext context) async {
    ResultWithValue<FeedbackFormWithQuestionsViewModel> apiResult =
        await getAssistantAppsApi().getLatestFeedbackForm();
    if (apiResult.hasFailed) {
      setState(() {
        networkState = NetworkState.Error;
      });
      return;
    }

    setState(() {
      networkState = NetworkState.Success;
      items = apiResult.value.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenMediaQuery = MediaQuery.of(context).size;

    if (networkState == NetworkState.Loading) {
      return Center(child: getLoading().smallLoadingIndicator());
    }
    if (networkState == NetworkState.Error) {
      return Center(child: getLoading().customErrorWidget(context));
    }

    return innerBody(
      context,
      screenMediaQuery,
      items,
    );
  }

  Widget innerBody(
    BuildContext fabCtx,
    Size screenMediaQuery,
    List<FeedbackFormQuestionViewModel> items,
  ) {
    FeedbackFormQuestionViewModel currentQuestion = items[questionIndex];

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        emptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
        ),
        emptySpace3x(),
        genericItemName(currentQuestion.questionText),
        emptySpace3x(),
        TextField(
          keyboardType: TextInputType.multiline,
          minLines: screenMediaQuery.height > 400 ? 2 : 1,
          maxLines: 12,
          maxLength: 500,
          cursorColor: getTheme().getPrimaryColour(fabCtx),
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: darken(getTheme().getPrimaryColour(fabCtx), 0.25),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: getTheme().getPrimaryColour(fabCtx),
              ),
            ),
            hintText: 'I think that...', // TODO translate
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          ),
        ),
        emptySpace1x(),
        renderControls(questionIndex, items.length),
        emptySpace3x(),
      ],
    );
  }

  Widget renderControls(int qIndex, int numItems) {
    Widget Function() negativeButtonWidget = () => negativeButton(
          title: getTranslations().fromKey(LocaleKey.previousWeekendMission),
          backgroundColour: Colors.grey,
          onPress: () {
            setState(() {
              questionIndex = qIndex - 1;
            });
          },
        );

    Widget Function() positiveButtonWidget = () => positiveButton(
          context,
          title: getTranslations().fromKey(LocaleKey.nextWeekendMission),
          onPress: () {
            setState(() {
              questionIndex = qIndex + 1;
            });
          },
        );

    if (qIndex == 0) {
      negativeButtonWidget = () => negativeButton(
            title: getTranslations().fromKey(LocaleKey.cancel),
            backgroundColour: Colors.grey,
            onPress: () {
              widget.feedbackServices.feedbackAnimationState =
                  FeedbackAnimationState.closing;
              setState(() {
                questionIndex = 0;
              });
            },
          );
    }

    if ((qIndex + 1) >= numItems) {
      positiveButtonWidget = () => positiveButton(
            context,
            title: getTranslations().fromKey(LocaleKey.seconds),
            onPress: () {},
          );
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        negativeButtonWidget(),
        positiveButtonWidget(),
      ],
    );
  }
}
