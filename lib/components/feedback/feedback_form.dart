import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../contracts/enum/feedback_question_type.dart';
import '../../contracts/generated/feedback/feedback_form_answer_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_question_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
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
  List<FeedbackFormAnswerViewModel> answers = List.empty(growable: true);
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

  void saveAnswerToQuestion(String questionGuid, String answer) {
    FeedbackFormAnswerViewModel answerVm = FeedbackFormAnswerViewModel(
      feedbackQuestionGuid: questionGuid,
      value: answer,
    );

    int existingItemIndex =
        answers.indexWhere((q) => q.feedbackQuestionGuid == questionGuid);
    if (existingItemIndex > 0) {
      setState(() {
        answers[existingItemIndex] = answerVm;
      });
      return;
    }

    setState(() {
      answers.add(answerVm);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenMediaQuery = MediaQuery.of(context).size;

    if (networkState == NetworkState.loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: getLoading().smallLoadingIndicator(),
        ),
      );
    }
    if (networkState == NetworkState.error) {
      return Center(child: getLoading().customErrorWidget(context));
    }

    List<Widget> columnWidgets = List.empty(growable: true);
    FeedbackFormQuestionViewModel currentQuestion = items[questionIndex];

    if (currentQuestion.questionType != FeedbackQuestionType.Screenshot) {
      columnWidgets.addAll([
        emptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
        ),
        emptySpace3x(),
        Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(4.0),
          child: Text(
            currentQuestion.questionText,
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        emptySpace3x(),
        FeedbackFormInput(
          feedbackQuestionType: currentQuestion.questionType,
          screenMediaQuery: screenMediaQuery,
          saveAnswer: (answer) => saveAnswerToQuestion(
            currentQuestion.guid,
            answer,
          ),
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
    Widget Function() negativeButtonWidget = () => NegativeButton(
          title: 'Previous', //TODO translate
          backgroundColour: Colors.grey,
          onTap: () {
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

    Widget Function() positiveButtonWidget = () => PositiveButton(
          title: 'Next', //TODO translate
          onTap: () {
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
      negativeButtonWidget = () => NegativeButton(
            title: 'Cancel', //TODO translate
            backgroundColour: Colors.grey,
            onTap: () {
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
      positiveButtonWidget = () => PositiveButton(
            title: 'Submit', //TODO translate
            onTap: () {
              for (var answer in answers) {
                print(answer);
              }
            },
          );
    }

    if (currentQuestionType == FeedbackQuestionType.Screenshot) {
      if (localServices.feedbackScreenshotState ==
          FeedbackScreenshotState.active) {
        screenshotButtonWidget = () => PositiveButton(
              title: 'Capture', //TODO translate
              onTap: () async {
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
        // screenshotButtonWidget = () => PositiveButton(
        //       title: 'Save & upload', //TODO translate
        //       onTap: () async {
        //         var imageState = localServices.painterKey.currentState;
        //         if (imageState == null) {
        //           return;
        //         }

        //         final finalImage = await imageState.exportImage();
        //       },
        //     );
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
