import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/networkState.dart';
import '../common/space.dart';
import '../common/text.dart';
import 'feedback_form_header.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm>
    with AfterLayoutMixin<FeedbackForm>, TickerProviderStateMixin {
  NetworkState networkState = NetworkState.Loading;

  @override
  void afterFirstLayout(BuildContext context) => checkForNotices(context);

  Future<void> checkForNotices(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3));

    setState(() {
      networkState = NetworkState.Success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        emptySpace3x(),
        const FeedbackFormHeader(
          currentStep: 1,
          totalSteps: 3,
          title: 'Message',
        ),
        emptySpace3x(),
        const Text(
          'What is your feedback?',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 28),
        ),
        genericItemDescription('Please provide a short description'),
        emptySpace3x(),
      ],
    );
  }
}
