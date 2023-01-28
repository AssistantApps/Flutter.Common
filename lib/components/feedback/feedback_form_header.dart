import 'package:flutter/material.dart';

import '../common/space.dart';
import '../common/text.dart';

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
        GenericItemDescription('Step $currentStep of $totalSteps'),
        const EmptySpace1x(),
        const GenericItemDescription(' | '),
        const EmptySpace1x(),
        GenericItemDescription(title),
      ],
    );
  }
}
