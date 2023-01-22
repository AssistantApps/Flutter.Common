import 'package:flutter/material.dart';

import 'feedback_animation_state.dart';

class FeedbackServices extends ChangeNotifier {
  // FeedbackServices() {}

  FeedbackAnimationState _feedbackAnimationState =
      FeedbackAnimationState.closed;

  FeedbackAnimationState get feedbackAnimationState => _feedbackAnimationState;

  set feedbackAnimationState(FeedbackAnimationState feedbackAnimationState) {
    _feedbackAnimationState = feedbackAnimationState;
    notifyListeners();
  }

  show() {
    _feedbackAnimationState = FeedbackAnimationState.opening;
    notifyListeners();
  }

  close() {
    _feedbackAnimationState = FeedbackAnimationState.closing;
    notifyListeners();
  }
}
