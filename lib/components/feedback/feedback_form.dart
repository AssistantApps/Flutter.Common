import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/feedback_question_type.dart';
import '../../contracts/enum/networkState.dart';
import '../../contracts/generated/feedback/feedback_form_question_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjectionApi.dart';
import '../../integration/dependencyInjectionBase.dart';
import '../adaptive/button.dart';
import '../common/space.dart';
import '../common/text.dart';
import 'feedback_animation_state.dart';
import 'feedback_constants.dart';
import 'feedback_form_header.dart';
import 'feedback_form_input.dart';
import 'feedback_screenshot_state.dart';
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
  NetworkState networkState = NetworkState.loading;
  List<FeedbackFormQuestionViewModel> items = List.empty(growable: true);
  int questionIndex = 0;

  @override
  void afterFirstLayout(BuildContext context) => getLatestFeedbackForm(context);

  Future<void> getLatestFeedbackForm(BuildContext context) async {
    ResultWithValue<FeedbackFormWithQuestionsViewModel> apiResult =
        await getAssistantAppsApi().getLatestFeedbackForm();
    if (apiResult.hasFailed) {
      setState(() {
        networkState = NetworkState.error;
      });
      return;
    }

    setState(() {
      networkState = NetworkState.success;
      items = apiResult.value.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenMediaQuery = MediaQuery.of(context).size;

    if (networkState == NetworkState.loading) {
      return Center(child: getLoading().smallLoadingIndicator());
    }
    if (networkState == NetworkState.error) {
      return Center(child: getLoading().customErrorWidget(context));
    }

    FeedbackFormQuestionViewModel currentQuestion = items[questionIndex];

    List<Widget> columnWidgets = List.empty(growable: true);

    if (currentQuestion.questionType != FeedbackQuestionType.Screenshot) {
      columnWidgets.addAll([
        emptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
        ),
        emptySpace3x(),
        genericItemName(currentQuestion.questionText),
        emptySpace2x(),
        FeedbackFormInput(
          feedbackQuestionType: currentQuestion.questionType,
          screenMediaQuery: screenMediaQuery,
        ),
        emptySpace1x(),
        renderControls(
          questionIndex,
          items.length,
          currentQuestion.questionType,
          widget.feedbackServices,
        ),
        emptySpace3x(),
      ]);
    } else {
      columnWidgets.addAll([
        emptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
        ),
        emptySpace1x(),
        renderControls(
          questionIndex,
          items.length,
          currentQuestion.questionType,
          widget.feedbackServices,
        ),
        emptySpace3x(),
      ]);
    }

    return AnimatedSize(
      duration: FeedbackConstants.openCloseAnimDuration,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnWidgets,
      ),
    );
  }

  Widget renderControls(
    int qIndex,
    int numItems,
    FeedbackQuestionType currentQuestionType,
    FeedbackServices localServices,
  ) {
    Widget Function() negativeButtonWidget = () => negativeButton(
          title: 'Previous', //TODO translate
          backgroundColour: Colors.grey,
          onPress: () {
            int prevQuestionIndex = qIndex - 1;
            FeedbackFormQuestionViewModel prevQuestion =
                items[prevQuestionIndex];
            if (prevQuestion.questionType == FeedbackQuestionType.Screenshot) {
              localServices.feedbackScreenshotState =
                  FeedbackScreenshotState.active;
            } else {
              localServices.feedbackScreenshotState =
                  FeedbackScreenshotState.notActive;
            }
            setState(() {
              questionIndex = prevQuestionIndex;
            });
          },
        );

    Widget? Function() screenshotButtonWidget = () => null;

    Widget Function() positiveButtonWidget = () => positiveButton(
          context,
          title: 'Next', //TODO translate
          onPress: () {
            int nextQuestionIndex = qIndex + 1;
            FeedbackFormQuestionViewModel nextQuestion =
                items[nextQuestionIndex];
            if (nextQuestion.questionType == FeedbackQuestionType.Screenshot) {
              localServices.feedbackScreenshotState =
                  FeedbackScreenshotState.active;
            } else {
              localServices.feedbackScreenshotState =
                  FeedbackScreenshotState.notActive;
            }

            setState(() {
              questionIndex = nextQuestionIndex;
            });
          },
        );

    if (qIndex == 0) {
      negativeButtonWidget = () => negativeButton(
            title: 'Cancel', //TODO translate
            backgroundColour: Colors.grey,
            onPress: () {
              localServices.feedbackScreenshotState =
                  FeedbackScreenshotState.notActive;
              localServices.feedbackAnimationState =
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
            title: 'Submit', //TODO translate
            onPress: () {},
          );
    }

    if (currentQuestionType == FeedbackQuestionType.Screenshot) {
      if (localServices.feedbackScreenshotState ==
          FeedbackScreenshotState.active) {
        screenshotButtonWidget = () => positiveButton(
              context,
              title: 'Capture', //TODO translate
              onPress: () async {
                try {
                  Uint8List? data =
                      await localServices.screenshotController.capture();

                  if (data == null) return;
                  localServices.screenshotData = data;

                  // ignore: empty_catches
                } on Exception {}
              },
            );
      }
      if (localServices.feedbackScreenshotState ==
          FeedbackScreenshotState.draw) {
        screenshotButtonWidget = () => positiveButton(
              context,
              title: 'Save & upload', //TODO translate
              onPress: () async {
                var imageState = localServices.painterKey.currentState;
                if (imageState == null) {
                  return;
                }

                final finalImage = await imageState.exportImage();
              },
            );
      }
    }

    Widget? screenshotButton = screenshotButtonWidget();
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        negativeButtonWidget(),
        if (screenshotButton != null) ...[screenshotButton],
        positiveButtonWidget(),
      ],
    );
  }
}
