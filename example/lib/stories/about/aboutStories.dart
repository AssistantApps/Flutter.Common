import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/pages/about/aboutPageAvailableApps.dart';
import 'package:assistantapps_flutter_common/pages/about/aboutPageTeam.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/StorybookNames.dart';
import '../../knobs/assistantAppTypes.dart';

List<Story> getAboutStories() {
  return [
    Story(
      name: StorybookNames.AboutPage,
      description: 'Full page with all default pages',
      builder: (context) => AboutPage(
        key: Key(context.knobs.toString()),
        appType: context.knobs.options(
          label: 'AppType',
          initial: AssistantAppType.Unknown,
          options: getAssistantAppTypeOptions(),
        ),
      ),
    ),
    Story(
      name: StorybookNames.AboutPageContent,
      description: 'First tab of the about page',
      builder: (context) => AboutPageAvailableApps(AssistantAppType.Unknown),
    ),
    Story(
      name: StorybookNames.AboutTeamPage,
      description: 'Lists the Team members',
      builder: (context) => AboutPageTeam(),
    ),
    Story(
      name: StorybookNames.AboutPageCustom,
      description: 'Example of custom content',
      builder: (context) => AboutPage(
        key: Key(context.knobs.toString()),
        appType: context.knobs.options(
          label: 'AppType',
          initial: AssistantAppType.Unknown,
          options: getAssistantAppTypeOptions(),
        ),
        aboutPageWidgetsFunc: (innerCtx) => [
          Text('My app\'s specific content'),
        ],
      ),
    ),
  ];
}
