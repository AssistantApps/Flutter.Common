import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class LanguageHelpPage extends StatelessWidget {
  final String analyticsKey;
  final List<Widget>? additionalButtons;

  LanguageHelpPage(
    this.analyticsKey, {
    Key? key,
    this.additionalButtons,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(getTranslations().fromKey(LocaleKey.language)),
        showHomeAction: true,
      ),
      body: LanguagePageContent(additionalButtons: additionalButtons),
    );
  }
}
