import 'package:flutter/material.dart';

import '../../contracts/enum/assistant_app_type.dart';
import '../../contracts/enum/locale_key.dart';
import '../../contracts/generated/steam_news_item_view_model.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import './steamNewsListPageComponent.dart';

class SteamNewsPage extends StatelessWidget {
  final String analyticsKey;
  final Widget? bottomNavigationBar;
  final AssistantAppType appType;
  final Future<ResultWithValue<List<SteamNewsItemViewModel>>> Function(
      BuildContext) backupFunc;

  SteamNewsPage(
    this.analyticsKey,
    this.appType, {
    Key? key,
    this.bottomNavigationBar,
    required this.backupFunc,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsKey);
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
      body: SteamNewsListPageComponent(appType, backupFunc: backupFunc),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
