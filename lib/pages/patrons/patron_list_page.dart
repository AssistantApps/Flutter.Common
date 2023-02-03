import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../integration/dependency_injection.dart';
import './patron_list_page_component.dart';

class PatronListPage extends StatelessWidget {
  final String analyticsKey;
  final Widget? bottomNavigationBar;

  PatronListPage(this.analyticsKey, {Key? key, this.bottomNavigationBar})
      : super(key: key) {
    getAnalytics().trackEvent(analyticsKey);
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
      body: const PatronListPageComponent(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
