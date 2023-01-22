import 'package:flutter/material.dart';

import '../../integration/dependencyInjectionBase.dart';
import '../common/animation.dart';
import 'feedback_animation_state.dart';
import 'feedback_constants.dart';
import 'feedback_form.dart';
import 'feedback_services.dart';

class FeedbackWrapper extends StatefulWidget {
  final Widget child;

  const FeedbackWrapper({
    Key? key,
    required this.child,
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

  AnimationController? _controller;
  Animation<double>? _animation;

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
    final Widget materialApp = KeyedSubtree(
      key: _appKey,
      child: widget.child,
    );

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

    Size screenMediaQuery = MediaQuery.of(context).size;
    bool animateOpenClose =
        _services.feedbackAnimationState == FeedbackAnimationState.open ||
            _services.feedbackAnimationState == FeedbackAnimationState.opening;

    return Column(
      children: [
        SizeTransition(
          sizeFactor: _animation!,
          axis: Axis.vertical,
          child: Padding(
            padding: FeedbackConstants.miniAppPadding,
            child: FeedbackForm(),
          ),
        ),
        Expanded(
          child: AnimatedPadding(
            padding: animateOpenClose
                ? FeedbackConstants.miniAppPadding
                : EdgeInsets.zero,
            duration: FeedbackConstants.openingAnimDuration,
            curve: Curves.easeInOut,
            child: Stack(
              fit: StackFit.expand,
              children: [
                materialApp,
                if (_services.feedbackAnimationState ==
                        FeedbackAnimationState.open ||
                    _services.feedbackAnimationState ==
                        FeedbackAnimationState.opening) ...[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: screenMediaQuery.height,
                    child: GestureDetector(
                      child: animateWidgetIn(
                        duration: FeedbackConstants.openingAnimDuration,
                        child: ClipRRect(
                          borderRadius: FeedbackConstants.miniAppBorderRadius,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                color: getTheme().getPrimaryColour(context),
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    'Return to app',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _services.dispose();
    super.dispose();
  }
}
