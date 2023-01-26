import 'package:flutter/material.dart';

class FeedbackOptions {
  final String? buildNumber;
  final String? buildVersion;
  final String? buildCommit;
  final Color? returnToAppBannerColour;
  final String currentLang;
  final bool isPatron;

  const FeedbackOptions({
    required this.buildNumber,
    required this.buildVersion,
    required this.buildCommit,
    required this.currentLang,
    required this.isPatron,
    this.returnToAppBannerColour,
  });
}
