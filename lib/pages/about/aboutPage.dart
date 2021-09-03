import 'package:assistantapps_flutter_common/constants/AppImage.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import 'aboutPageAvailableApps.dart';

class AboutPage extends StatefulWidget {
  final AssistantAppType appType;
  final List<Widget> aboutPageWidgets;
  AboutPage({
    this.appType = AssistantAppType.Unknown,
    this.aboutPageWidgets,
  });

  @override
  _AboutPageWidget createState() => _AboutPageWidget(
        this.appType,
        this.aboutPageWidgets,
      );
}

class _AboutPageWidget extends State<AboutPageAvailableApps> {
  final AssistantAppType appType;
  List<Widget> aboutPageWidgets;
  int tabSelection = 0;
  _AboutPageWidget(this.appType, List<Widget> aboutPageWidgetsList) {
    this.aboutPageWidgets = aboutPageWidgetsList ?? List.empty();
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.about)),
      ),
      body: Column(
        key: Key('currentSelection: $tabSelection'),
        children: <Widget>[
          Container(
            child: adaptiveSegmentedControl(
              context,
              controlItems: [
                getSegmentedControlWithIconOption(
                  Icons.help_outline,
                  getTranslations().fromKey(LocaleKey.about),
                ),
                getSegmentedControlWithIconOption(
                  Icons.apps_rounded,
                  getTranslations().fromKey(LocaleKey.appStore),
                ),
                getSegmentedControlWithIconOption(
                  Icons.people_alt,
                  getTranslations().fromKey(LocaleKey.tree),
                )
              ],
              currentSelection: tabSelection,
              onSegmentChosen: (int newTab) => this.setState(() {
                this.tabSelection = newTab;
              }),
            ),
          ),
          ...buildPage(context, this.tabSelection),
        ],
      ),
    );
  }

  List<Widget> buildPage(BuildContext context, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return this.aboutPageWidgets;
      case 1:
        return [AboutPageAvailableApps(this.appType)];
    }

    return [Text(getTranslations().fromKey(LocaleKey.noItems))];
  }
}
