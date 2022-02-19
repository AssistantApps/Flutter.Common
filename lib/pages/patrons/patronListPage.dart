import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import 'patronListPageComponent.dart';

class PatronListPage extends StatelessWidget {
  final String analyticsKey;
  final Widget? bottomNavigationBar;
  PatronListPage(this.analyticsKey, {this.bottomNavigationBar}) {
    getAnalytics().trackEvent(this.analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.patrons)),
      ),
      body: PatronListPageComponent(),
      bottomNavigationBar: this.bottomNavigationBar,
    );
  }
}
