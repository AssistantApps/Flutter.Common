import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

class WhatIsNewPage extends StatelessWidget {
  final String analyticsKey;
  final String selectedLanguage;
  final List<Widget> Function() additionalBuilder;

  WhatIsNewPage(
    this.analyticsKey, {
    @required this.selectedLanguage,
    this.additionalBuilder,
  }) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    var currentWhatIsNewGuid = getEnv().currentWhatIsNewGuid;
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.whatIsNew)),
      ),
      body: WhatIsNewPageComponent(
        currentWhatIsNewGuid,
        this.selectedLanguage,
        getPlatforms(),
        smallLoadMorePageButton(context),
        (version) async => await getNavigation().navigateAsync(
          context,
          navigateTo: (context) => WhatIsNewDetailPage(
            currentWhatIsNewGuid,
            version,
            additionalBuilder: additionalBuilder,
          ),
        ),
      ),
    );
  }
}
