import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import 'aboutPageAvailableApps.dart';
import 'aboutPageTeam.dart';

class AboutPage extends StatefulWidget {
  final AssistantAppType appType;
  final List<Widget> Function(BuildContext context)? aboutPageWidgetsFunc;
  AboutPage({
    this.appType = AssistantAppType.Unknown,
    this.aboutPageWidgetsFunc,
  });

  @override
  _AboutPageWidget createState() => _AboutPageWidget();
}

class _AboutPageWidget extends State<AboutPage> {
  late List<Widget> Function(BuildContext context) aboutPageWidgetsFunc;
  int tabSelection = 0;

  _AboutPageWidget() {
    this.aboutPageWidgetsFunc =
        widget.aboutPageWidgetsFunc ?? (_) => List.empty();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      getSegmentedControlWithIconOption(
        Icons.apps_rounded,
        'AssistantApps',
      ),
      getSegmentedControlWithIconOption(
        Icons.help_outline,
        'This app',
      ),
      getSegmentedControlWithIconOption(
        Icons.people_alt,
        'Team',
      ),
    ];
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
          if (options.length > 1) ...[
            Container(
              child: adaptiveSegmentedControl(
                context,
                verticalOffset: 8,
                controlItems: options,
                currentSelection: tabSelection,
                onSegmentChosen: (int newTab) => this.setState(() {
                  this.tabSelection = newTab;
                }),
              ),
            ),
            customDivider(),
          ],
          Column(
            mainAxisSize: MainAxisSize.max,
            children: buildPage(context, this.tabSelection),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPage(BuildContext pageContext, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return [AboutPageAvailableApps(widget.appType)];
      case 1:
        return this.aboutPageWidgetsFunc(pageContext);
      case 2:
        return [AboutPageTeam()];
    }

    return [
      emptySpace1x(),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          genericItemName(getTranslations().fromKey(LocaleKey.noItems)),
        ],
      )
    ];
  }
}
