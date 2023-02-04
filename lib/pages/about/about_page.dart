import 'package:flutter/material.dart';

import '../../components/adaptive/segmented_control.dart';
import '../../components/common/space.dart';
import '../../components/common/text.dart';
import '../../contracts/enum/assistant_app_type.dart';
import '../../contracts/enum/locale_key.dart';
import '../../helpers/device_helper.dart';
import '../../integration/dependency_injection.dart';
import './about_page_available_apps.dart';
import './about_page_team.dart';

class AboutPage extends StatefulWidget {
  final AssistantAppType appType;
  final List<Widget> Function(BuildContext context)? aboutPageWidgetsFunc;

  const AboutPage({
    Key? key,
    this.appType = AssistantAppType.unknown,
    this.aboutPageWidgetsFunc,
  }) : super(key: key);

  @override
  createState() => _AboutPageWidget();
}

class _AboutPageWidget extends State<AboutPage> {
  int tabSelection = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [
      const SegmentedControlWithIconOption(
        icon: Icons.apps_rounded,
        text: 'AssistantApps',
      ),
      if (widget.aboutPageWidgetsFunc != null) ...[
        const SegmentedControlWithIconOption(
          icon: Icons.help_outline,
          text: 'This app',
        ),
      ],
      const SegmentedControlWithIconOption(
        icon: Icons.people_alt,
        text: 'Team',
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
            AdaptiveSegmentedControl(
              verticalOffset: 8,
              controlItems: options,
              currentSelection: tabSelection,
              onSegmentChosen: (int newTab) => setState(() {
                tabSelection = newTab;
              }),
            ),
            customDivider(),
          ],
          Column(
            key: Key(widget.appType.toString()),
            mainAxisSize: MainAxisSize.max,
            children: buildPage(context, tabSelection),
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
      () => [const AboutPageTeam()],
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
        const EmptySpace1x(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericItemName(getTranslations().fromKey(LocaleKey.noItems)),
          ],
        )
      ];
    }
  }
}
