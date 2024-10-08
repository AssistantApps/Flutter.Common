import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../integration/dependency_injection.dart';

class WhatIsNewDetailPage extends StatelessWidget {
  final VersionViewModel version;
  final String analyticsKey;
  final List<Widget> Function(VersionViewModel)? additionalBuilder;

  WhatIsNewDetailPage(
    this.analyticsKey,
    this.version, {
    super.key,
    this.additionalBuilder,
  }) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(version.buildName),
      ),
      body: ContentHorizontalSpacing(
        child: WhatIsNewDetailPageComponent(
          getEnv().assistantAppsAppGuid,
          version,
          additionalBuilder: additionalBuilder,
        ),
      ),
    );
  }
}
