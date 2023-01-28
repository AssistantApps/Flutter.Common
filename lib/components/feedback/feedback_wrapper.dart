import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../assistantapps_flutter_common.dart';
import 'feedback_animation_state.dart';
import 'feedback_constants.dart';
import 'feedback_form.dart';
import 'feedback_form_painter.dart';
import 'feedback_screenshot_state.dart';
import 'feedback_services.dart';
import 'feedback_wrapper_top_layer.dart';

class FeedbackWrapper extends StatefulWidget {
  final FeedbackOptions options;
  final Widget child;

  const FeedbackWrapper({
    Key? key,
    required this.child,
    required this.options,
  }) : super(key: key);

  @override
  createState() => FeedbackWrapperState();

  static FeedbackServices of(BuildContext context) {
    final state = context.findAncestorStateOfType<FeedbackWrapperState>();
    if (state == null) {
      throw StateError('Could not find FeedbackWrapperState in ancestors');
    }
    return state._services;
  }
}

class FeedbackWrapperState extends State<FeedbackWrapper>
    with TickerProviderStateMixin {
  final GlobalKey _appKey = GlobalKey(debugLabel: 'feedbackapp');
  final FeedbackServices _services = FeedbackServices();

  Animation<double>? _openCloseAnimation;
  AnimationController? _openCloseController;

  @override
  void initState() {
    super.initState();
    _openCloseController = AnimationController(
      vsync: this,
      duration: FeedbackConstants.openCloseAnimDuration,
    );

    _openCloseAnimation = CurvedAnimation(
      parent: _openCloseController!,
      curve: Curves.easeInOut,
    );

    _services.addListener(_rebuild);
  }

  void _rebuild() {
    // rebuild the Wiredash widget state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenMediaQuery = MediaQuery.of(context).size;

    if (_services.feedbackAnimationState == FeedbackAnimationState.opening) {
      _openCloseController?.forward().whenComplete(() {
        _services.feedbackAnimationState = FeedbackAnimationState.open;
      });
    }

    if (_services.feedbackAnimationState == FeedbackAnimationState.closing) {
      _openCloseController?.reverse().whenComplete(() {
        _services.feedbackAnimationState = FeedbackAnimationState.closed;
      });
    }

    if (_services.feedbackScreenshotState ==
        FeedbackScreenshotState.switchingToDraw) {
      Future.delayed(FeedbackConstants.flashAnimDuration).then((_) {
        _services.feedbackScreenshotState = FeedbackScreenshotState.draw;
      });
    }

    bool feedbackIsOpen =
        _services.feedbackAnimationState == FeedbackAnimationState.open ||
            _services.feedbackAnimationState == FeedbackAnimationState.opening;
    bool feedbackIsClosed =
        _services.feedbackAnimationState != FeedbackAnimationState.closed;
    double miniAppMultiply =
        feedbackIsOpen ? FeedbackConstants.miniAppShrinkPerc : 1;
    double miniAppWidth = screenMediaQuery.width * miniAppMultiply;
    double miniAppHeight = screenMediaQuery.height * miniAppMultiply;

    BorderRadius borderRadius =
        _services.feedbackAnimationState == FeedbackAnimationState.open
            ? FeedbackConstants.miniAppBorderRadius
            : BorderRadius.zero;

    KeyedSubtree materialApp = KeyedSubtree(
      key: _appKey,
      child: widget.child,
    );

    List<Widget> stackWidgets = [materialApp];
    if (_services.feedbackAnimationState == FeedbackAnimationState.open ||
        _services.feedbackAnimationState == FeedbackAnimationState.opening) {
      if (_services.feedbackScreenshotState != FeedbackScreenshotState.active) {
        stackWidgets.add(
          FeedbackWrapperTopLayer(
            feedbackServices: _services,
            options: widget.options,
          ),
        );
      }
    }

    if (_services.feedbackScreenshotState == FeedbackScreenshotState.active ||
        _services.feedbackScreenshotState ==
            FeedbackScreenshotState.switchingToDraw) {
      stackWidgets = [
        Screenshot(
          controller: _services.screenshotController,
          child: materialApp,
        ),
        AnimatedOpacity(
          opacity: _services.feedbackScreenshotState ==
                  FeedbackScreenshotState.switchingToDraw
              ? 1.0
              : 0.0,
          duration: FeedbackConstants.flashAnimDuration,
          child: IgnorePointer(
            ignoring: true,
            child: Container(color: Colors.grey[200]),
          ),
        )
      ];
    }

    if (_services.feedbackScreenshotState == FeedbackScreenshotState.draw) {
      stackWidgets = [
        Container(color: Colors.grey[200]),
        animateWidgetIn(
          duration: FeedbackConstants.flashAnimDuration,
          child: FeedbackFormPainter(
            feedbackServices: _services,
          ),
        ),
      ];
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            getTheme().getScaffoldBackgroundColour(context),
            darken(getTheme().getScaffoldBackgroundColour(context), 0.25),
          ],
        ),
      ),
      child: Column(
        children: [
          SizeTransition(
            sizeFactor: _openCloseAnimation!,
            axis: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (screenMediaQuery.width - miniAppWidth) / 2,
              ),
              child: feedbackIsClosed
                  ? FeedbackForm(feedbackServices: _services)
                  : const EmptySpace(0),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              width: miniAppWidth,
              height: miniAppHeight,
              duration: FeedbackConstants.openCloseAnimDuration,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Stack(
                  fit: StackFit.expand,
                  children: stackWidgets,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _services.dispose();
    _openCloseController?.dispose();
    super.dispose();
  }
}
