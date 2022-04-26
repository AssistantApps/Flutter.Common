import 'package:flutter/material.dart';

import '../../components/adaptive/segmentedControl.dart';
import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../contracts/enum/assistantAppType.dart';
import '../../contracts/enum/localeKey.dart';
import '../../helpers/deviceHelper.dart';
import '../../integration/dependencyInjection.dart';
import 'aboutPageAvailableApps.dart';
import 'aboutPageTeam.dart';

class AboutPage extends StatefulWidget {
  final Key key;
  final AssistantAppType appType;
  final List<Widget> Function(BuildContext context)? aboutPageWidgetsFunc;
  AboutPage({
    required this.key,
    this.appType = AssistantAppType.Unknown,
    this.aboutPageWidgetsFunc,
  }) : super(key: key);

  @override
  _AboutPageWidget createState() => _AboutPageWidget();
}

class _AboutPageWidget extends State<AboutPage> {
  int tabSelection = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      getSegmentedControlWithIconOption(
        Icons.apps_rounded,
        'AssistantApps',
      ),
      if (widget.aboutPageWidgetsFunc != null) ...[
        getSegmentedControlWithIconOption(
          Icons.help_outline,
          'This app',
        ),
      ],
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
            key: Key(widget.appType.toString()),
            mainAxisSize: MainAxisSize.max,
            children: buildPage(context, this.tabSelection),
          ),
        ],
      ),
    );
  }

  List<List<Widget> Function()> getPages(BuildContext pageContext) {
    return [
      () => [AboutPageAvailableApps(widget.appType)],
      if (widget.aboutPageWidgetsFunc != null) ...[
        () => widget.aboutPageWidgetsFunc!(pageContext),
      ],
      () => [AboutPageTeam()],
    ];
  }

  List<Widget> buildPage(BuildContext pageContext, int tabIndex) {
    List<List<Widget> Function()> pageFuncs = getPages(pageContext);
    try {
      List<Widget> Function() pageFunc = pageFuncs[tabIndex];
      return pageFunc();
    } //
    catch (ex) {
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
}
