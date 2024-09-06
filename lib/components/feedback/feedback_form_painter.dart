import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

import 'feedback_services.dart';

class FeedbackFormPainter extends StatefulWidget {
  final FeedbackServices feedbackServices;

  const FeedbackFormPainter({
    super.key,
    required this.feedbackServices,
  });

  @override
  createState() => _FeedbackFormPainterState();
}

class _FeedbackFormPainterState extends State<FeedbackFormPainter> {
  final imagePainterController = ImagePainterController(
    strokeWidth: 8,
    color: Colors.red,
    mode: PaintMode.freeStyle,
  );

  @override
  Widget build(BuildContext context) {
    return ImagePainter.memory(
      widget.feedbackServices.screenshotData!,
      scalable: false,
      controller: imagePainterController,
      clearAllIcon: const Icon(Icons.delete, color: Colors.black87),
      key: widget.feedbackServices.painterKey,
    );
  }
}
