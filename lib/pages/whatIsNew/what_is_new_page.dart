import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../integration/dependency_injection.dart';

class WhatIsNewPage extends StatelessWidget {
  final String analyticsKey;
  final String selectedLanguage;
  final List<PlatformType>? overriddenPlatforms;
  final List<Widget> Function(VersionViewModel)? additionalBuilder;

  WhatIsNewPage(
    this.analyticsKey, {
    super.key,
    required this.selectedLanguage,
    this.overriddenPlatforms,
    this.additionalBuilder,
  }) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    String currentWhatIsNewGuid = getEnv().currentWhatIsNewGuid;
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.whatIsNew)),
      ),
      body: ContentHorizontalSpacing(
        child: WhatIsNewPageComponent(
          currentWhatIsNewGuid,
          selectedLanguage,
          overriddenPlatforms ?? getPlatforms(),
          const SmallLoadMorePageButton(),
          (version) async => await getNavigation().navigateAsync(
            context,
            navigateTo: (context) => WhatIsNewDetailPage(
              currentWhatIsNewGuid,
              version,
              additionalBuilder: additionalBuilder,
            ),
          ),
        ),
      ),
    );
  }
}
