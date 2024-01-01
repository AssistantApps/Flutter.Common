import 'dart:typed_data';

import 'package:after_layout/after_layout.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../../constants/app_image.dart';
import '../../contracts/enum/feedback_question_type.dart';
import '../../contracts/generated/feedback/feedback_form_answer_submission_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_answer_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_question_viewmodel.dart';
import '../../contracts/generated/feedback/feedback_form_with_questions_viewmodel.dart';
import 'feedback_constants.dart';
import 'feedback_form_header.dart';
import 'feedback_form_input.dart';
import 'feedback_screenshot_state.dart';
import 'feedback_services.dart';

class FeedbackForm extends StatefulWidget {
  final FeedbackServices feedbackServices;
  final FeedbackOptions options;
  final Size screenMediaQuery;

  const FeedbackForm({
    Key? key,
    required this.feedbackServices,
    required this.screenMediaQuery,
    required this.options,
  }) : super(key: key);

  @override
  createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm>
    with AfterLayoutMixin<FeedbackForm>, TickerProviderStateMixin {
  NetworkState networkState = NetworkState.loading;
  FeedbackFormWithQuestionsViewModel? viewmodel;
  bool feedbackSubmitted = false;
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
      viewmodel = apiResult.value;
    });
  }

  void saveAnswerToQuestion(String questionGuid, String answer) {
    FeedbackFormAnswerViewModel answerVm = FeedbackFormAnswerViewModel(
      feedbackQuestionGuid: questionGuid,
      value: answer,
    );

    int existingItemIndex =
        answers.indexWhere((q) => q.feedbackQuestionGuid == questionGuid);
    if (existingItemIndex >= 0) {
      setState(() {
        answers[existingItemIndex] = answerVm;
      });
      return;
    }

    setState(() {
      answers.add(answerVm);
    });
  }

  void sendFeedbackToServer() async {
    setState(() {
      networkState = NetworkState.loading;
    });
    String deviceId = await getDeviceId();
    FeedbackFormAnswerSubmissionViewModel payload =
        FeedbackFormAnswerSubmissionViewModel(
      items: answers,
      feedbackFormGuid: viewmodel!.guid,
      platformType: EnumToString.convertToString(
        getPlatforms().first,
      ),
      userUniqueIdentifier: deviceId,
    );
    Result submissionResult =
        await getAssistantAppsApi().submitFeedbackFormAnswers(payload);
    if (submissionResult.hasFailed) {
      setState(() {
        networkState = NetworkState.error;
      });
      return;
    }
    setState(() {
      networkState = NetworkState.success;
      feedbackSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (networkState == NetworkState.loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: getLoading().smallLoadingIndicator(),
        ),
      );
    }
    if (networkState == NetworkState.error) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmptySpace(5),
          Center(child: getLoading().customErrorWidget(context)),
          const EmptySpace1x(),
          Center(
            child: PositiveButton(
              title: 'Retry',
              onTap: sendFeedbackToServer,
            ),
          ),
          const EmptySpace3x(),
        ],
      );
    }

    List<Widget> columnWidgets = List.empty(growable: true);
    if (feedbackSubmitted) {
      columnWidgets.addAll([
        const EmptySpace3x(),
        animateSlideInFromLeft(
          child: LocalImage(
            imagePath: widget.options.successImageOnFormComplete ??
                AppImage.successGuide,
          ),
        ),
        const EmptySpace1x(),
        Center(
          child: Text(
            getTranslations().fromKey(LocaleKey.thankYou),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 28),
          ),
        ),
        const EmptySpace3x(),
      ]);
    } else {
      columnWidgets = _getFormComponents(widget.screenMediaQuery);
    }

    return AnimatedSize(
      duration: FeedbackConstants.openCloseAnimDuration,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EmptySpace3x(),
          ...columnWidgets,
        ],
      ),
    );
  }

  List<Widget> _getFormComponents(Size screenMediaQuery) {
    var items = viewmodel?.items ?? List.empty();
    FeedbackFormQuestionViewModel currentQuestion = items[questionIndex];

    List<Widget> columnWidgets = List.empty(growable: true);

    if (currentQuestion.questionType != FeedbackQuestionType.Screenshot) {
      columnWidgets.addAll([
        const EmptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
          closeForm: () => widget.feedbackServices.close(),
        ),
        const EmptySpace3x(),
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
        const EmptySpace3x(),
        FeedbackFormInput(
          key: Key(currentQuestion.guid.toString()),
          feedbackQuestionType: currentQuestion.questionType,
          screenMediaQuery: screenMediaQuery,
          saveAnswer: (answer) => saveAnswerToQuestion(
            currentQuestion.guid,
            answer,
          ),
        ),
        const EmptySpace1x(),
        renderControls(
          questionIndex,
          items.length,
          currentQuestion.questionType,
          widget.feedbackServices,
        ),
        const EmptySpace3x(),
      ]);
    } else {
      columnWidgets.addAll([
        const EmptySpace3x(),
        FeedbackFormHeader(
          currentStep: (questionIndex + 1),
          totalSteps: items.length,
          title: 'Feedback', // TODO translate
        ),
        const EmptySpace1x(),
        renderControls(
          questionIndex,
          items.length,
          currentQuestion.questionType,
          widget.feedbackServices,
        ),
        const EmptySpace3x(),
      ]);
    }

    return columnWidgets;
  }

  Widget renderControls(
    int qIndex,
    int numItems,
    FeedbackQuestionType currentQuestionType,
    FeedbackServices localServices,
  ) {
    Widget Function() negativeButtonWidget = () => NegativeButton(
          title: 'Previous', //TODO translate
          backgroundColour: Colors.grey[400]!,
          onTap: () {
            int prevQuestionIndex = qIndex - 1;
            FeedbackFormQuestionViewModel prevQuestion =
                viewmodel!.items[prevQuestionIndex];
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
                viewmodel!.items[nextQuestionIndex];
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
            backgroundColour: Colors.grey[400]!,
            onTap: () => widget.feedbackServices.close(),
          );
    }

    if ((qIndex + 1) >= numItems) {
      positiveButtonWidget = () => PositiveButton(
            title: 'Submit', //TODO translate
            onTap: sendFeedbackToServer,
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
