import 'package:flutter/material.dart';

import '../../contracts/enum/assistantAppType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../contracts/generated/steamNewsItemViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import 'SteamNewsListPageComponent.dart';

class SteamNewsPage extends StatelessWidget {
  final String analyticsKey;
  final Widget bottomNavigationBar;
  final AssistantAppType appType;
  final Future<ResultWithValue<List<SteamNewsItemViewModel>>> Function(
      BuildContext) backupFunc;
  SteamNewsPage(this.analyticsKey, this.appType,
      {this.bottomNavigationBar, this.backupFunc}) {
    getAnalytics().trackEvent(this.analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.steamNews)),
      ),
      body: SteamNewsListPageComponent(appType, backupFunc: this.backupFunc),
      bottomNavigationBar: this.bottomNavigationBar,
    );
  }
}
