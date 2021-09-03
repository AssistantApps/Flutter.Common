import 'package:flutter/material.dart';

import '../../contracts/enum/assistantAppType.dart';
import '../../pages/about/aboutPageAvailableApps.dart';

class AssistantAppsModalBottomSheet extends StatelessWidget {
  final AssistantAppType appType;
  AssistantAppsModalBottomSheet({this.appType = AssistantAppType.Unknown});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: Container(
        constraints: BoxConstraints(
          minHeight: (MediaQuery.of(context).size.height) / 2,
          maxHeight: (MediaQuery.of(context).size.height) * 0.75,
        ),
        child: AboutPageAvailableApps(this.appType),
      ),
    );
  }
}
