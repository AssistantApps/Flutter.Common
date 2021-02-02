import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

class WhatIsNewDetailPage extends StatelessWidget {
  final VersionViewModel version;
  final String analyticsKey;
  final List<Widget> Function() additionalBuilder;

  WhatIsNewDetailPage(
    this.analyticsKey,
    this.version, {
    this.additionalBuilder,
  }) {
    getAnalytics().trackEvent(this.analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(this.version.buildName),
      ),
      body: WhatIsNewDetailPageComponent(
        getEnv().assistantAppsAppGuid,
        version,
        additionalBuilder: additionalBuilder,
      ),
    );
  }
}
