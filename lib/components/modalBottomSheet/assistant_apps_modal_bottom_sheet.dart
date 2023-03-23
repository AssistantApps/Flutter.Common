import 'package:flutter/material.dart';

import '../../constants/modal.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../pages/about/about_page_available_apps.dart';

class AssistantAppsModalBottomSheet extends StatelessWidget {
  final AssistantAppType appType;
  const AssistantAppsModalBottomSheet(
      {Key? key, this.appType = AssistantAppType.unknown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: Container(
        constraints: modalDefaultSize(context),
        child: AboutPageAvailableApps(appType),
      ),
    );
  }
}
