import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/pages/about/aboutPageAvailableApps.dart';
import 'package:assistantapps_flutter_common/pages/about/aboutPageTeam.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/storybook_names.dart';
import '../../knobs/assistantapp_types.dart';

List<Story> getAboutStories() {
  return [
    Story(
      name: StorybookNames.aboutPage,
      description: 'Full page with all default pages',
      builder: (context) => AboutPage(
        key: Key(context.knobs.toString()),
        appType: context.knobs.options(
          label: 'AppType',
          initial: AssistantAppType.unknown,
          options: getAssistantAppTypeOptions(),
        ),
      ),
    ),
    Story(
      name: StorybookNames.aboutPageContent,
      description: 'First tab of the about page',
      builder: (context) =>
          const AboutPageAvailableApps(AssistantAppType.unknown),
    ),
    Story(
      name: StorybookNames.aboutTeamPage,
      description: 'Lists the Team members',
      builder: (context) => const AboutPageTeam(),
    ),
    Story(
      name: StorybookNames.aboutPageCustom,
      description: 'Example of custom content',
      builder: (context) => AboutPage(
        key: Key(context.knobs.toString()),
        appType: context.knobs.options(
          label: 'AppType',
          initial: AssistantAppType.unknown,
          options: getAssistantAppTypeOptions(),
        ),
        aboutPageWidgetsFunc: (innerCtx) => [
          const Text('My app\'s specific content'),
        ],
      ),
    ),
  ];
}
