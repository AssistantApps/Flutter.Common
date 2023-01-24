import 'package:flutter/material.dart';

import '../../helpers/colourHelper.dart';
import '../../integration/dependencyInjectionBase.dart';
import 'feedback_animation_state.dart';
import 'feedback_constants.dart';
import 'feedback_form.dart';
import 'feedback_options.dart';
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

  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: FeedbackConstants.openingAnimDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
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
    if (_services.feedbackAnimationState == FeedbackAnimationState.opening) {
      _controller?.forward().whenComplete(() {
        _services.feedbackAnimationState = FeedbackAnimationState.open;
      });
    }

    if (_services.feedbackAnimationState == FeedbackAnimationState.closing) {
      _controller?.reverse().whenComplete(() {
        _services.close();
      });
    }

    bool animateOpenClose =
        _services.feedbackAnimationState == FeedbackAnimationState.open ||
            _services.feedbackAnimationState == FeedbackAnimationState.opening;

    EdgeInsets animatedPadding = animateOpenClose //
        ? FeedbackConstants.miniAppPadding
        : EdgeInsets.zero;
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
      stackWidgets.add(
        FeedbackWrapperTopLayer(
          feedbackServices: _services,
          options: widget.options,
        ),
      );
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
            sizeFactor: _animation!,
            axis: Axis.vertical,
            child: Padding(
              padding: FeedbackConstants.miniAppPadding,
              child: FeedbackForm(
                feedbackServices: _services,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: AnimatedPadding(
                padding: animatedPadding,
                duration: FeedbackConstants.openingAnimDuration,
                curve: Curves.easeInOut,
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Stack(
                    fit: StackFit.expand,
                    children: stackWidgets,
                  ),
                ),
              ),
              onTap: () {
                _services.feedbackAnimationState =
                    FeedbackAnimationState.closing;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _services.dispose();
    _controller?.dispose();
    super.dispose();
  }
}
