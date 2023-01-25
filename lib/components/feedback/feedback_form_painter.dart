import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

import 'feedback_services.dart';

class FeedbackFormPainter extends StatefulWidget {
  final FeedbackServices feedbackServices;

  const FeedbackFormPainter({
    Key? key,
    required this.feedbackServices,
  }) : super(key: key);

  @override
  createState() => _FeedbackFormPainterState();
}

class _FeedbackFormPainterState extends State<FeedbackFormPainter> {
  @override
  Widget build(BuildContext context) {
    return ImagePainter.memory(
      widget.feedbackServices.screenshotData!,
      scalable: false,
      initialStrokeWidth: 8,
      initialColor: Colors.red,
      initialPaintMode: PaintMode.freeStyle,
      clearAllIcon: const Icon(Icons.delete, color: Colors.black87),
      key: widget.feedbackServices.painterKey,
    );
  }
}
