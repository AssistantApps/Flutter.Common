import 'package:flutter/material.dart';

import '../common/animation.dart';
import 'feedback_animation_state.dart';
import 'feedback_constants.dart';
import 'feedback_options.dart';
import 'feedback_services.dart';

class FeedbackWrapperTopLayer extends StatelessWidget {
  final FeedbackServices feedbackServices;
  final FeedbackOptions options;

  const FeedbackWrapperTopLayer({
    super.key,
    required this.feedbackServices,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: animateWidgetIn(
        duration: FeedbackConstants.openCloseAnimDuration,
        child: GestureDetector(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: options.returnToAppBannerColour ?? Colors.blue[800],
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Return to app', // TODO translate
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(child: Container(color: Colors.black.withOpacity(0.5))),
            ],
          ),
          onTap: () {
            feedbackServices.feedbackAnimationState =
                FeedbackAnimationState.closing;
          },
        ),
      ),
    );
  }
}
