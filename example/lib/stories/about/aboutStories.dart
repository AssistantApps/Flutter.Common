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
      builder: (context) => AboutPageAvailableApps(AssistantAppType.Unknown),
    ),
    Story(
      name: StorybookNames.AboutTeamPage,
      builder: (context) => AboutPageTeam(),
    ),
    Story(
      name: StorybookNames.AboutPageCustom,
      description: 'About page with custom content for the app running',
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
