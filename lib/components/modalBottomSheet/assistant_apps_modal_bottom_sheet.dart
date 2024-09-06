import 'package:flutter/material.dart';

import '../../constants/app_duration.dart';
import '../../constants/modal.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../pages/about/about_page_available_apps.dart';

class AssistantAppsModalBottomSheet extends StatelessWidget {
  final AssistantAppType appType;
  final ScrollController? controller;
  const AssistantAppsModalBottomSheet({
    super.key,
    this.appType = AssistantAppType.unknown,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: AppDuration.modal,
      child: Container(
        constraints: modalDefaultSize(context),
        child: AboutPageAvailableApps(appType, controller: controller),
      ),
    );
  }
}
