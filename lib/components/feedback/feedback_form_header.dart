import 'package:flutter/material.dart';

import '../common/space.dart';

class FeedbackFormHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String title;

  const FeedbackFormHeader({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('Step $currentStep of $totalSteps'),
        emptySpace1x(),
        const Text(' | '),
        emptySpace1x(),
        Text(title),
      ],
    );
  }
}
