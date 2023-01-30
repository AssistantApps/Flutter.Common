import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:screenshot/screenshot.dart';

import 'feedback_animation_state.dart';
import 'feedback_screenshot_state.dart';

class FeedbackServices extends ChangeNotifier {
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey<ImagePainterState> painterKey = GlobalKey<ImagePainterState>();

  // FeedbackServices() {}

  FeedbackAnimationState _feedbackAnimationState =
      FeedbackAnimationState.closed;
  FeedbackAnimationState get feedbackAnimationState => _feedbackAnimationState;
  set feedbackAnimationState(FeedbackAnimationState feedbackAnimationState) {
    _feedbackAnimationState = feedbackAnimationState;
    notifyListeners();
  }

  FeedbackScreenshotState _feedbackScreenshotState =
      FeedbackScreenshotState.notActive;
  FeedbackScreenshotState get feedbackScreenshotState =>
      _feedbackScreenshotState;
  set feedbackScreenshotState(FeedbackScreenshotState feedbackScreenshotState) {
    _feedbackScreenshotState = feedbackScreenshotState;
    notifyListeners();
  }

  Uint8List? _screenshotData;
  Uint8List? get screenshotData => _screenshotData;
  set screenshotData(Uint8List? screenshotData) {
    _screenshotData = screenshotData;
    _feedbackScreenshotState = FeedbackScreenshotState.switchingToDraw;
    notifyListeners();
  }

  show() {
    _feedbackAnimationState = FeedbackAnimationState.opening;
    notifyListeners();
  }

  close() {
    feedbackScreenshotState = FeedbackScreenshotState.notActive;
    feedbackAnimationState = FeedbackAnimationState.closing;
    notifyListeners();
  }
}
