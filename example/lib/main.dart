import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart'
    hide GuideApiService;
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'services/theme_service.dart';
import 'services/guideapi_service.dart';
import 'constants/storybook_names.dart';
import 'stories/about/about_stories.dart';
import 'stories/guide/guide_stories.dart';
import 'stories/home/home_stories.dart';
import 'stories/searchList/searchlist_stories.dart';

void main() => runApp(const StorybookApp());

final _plugins = initializePlugins(
  contentsSidePanel: true,
  knobsSidePanel: true,
  initialDeviceFrameData: DeviceFrameData(
    device: Devices.ios.iPhone13ProMax,
  ),
);

class StorybookApp extends StatefulWidget {
  const StorybookApp({Key? key}) : super(key: key);

  @override
  _StorybookAppState createState() => _StorybookAppState();
}

class _StorybookAppState<T> extends State<StorybookApp>
    with AfterLayoutMixin<StorybookApp> {
  //
  bool hasLoaded = false;
  //
  final AssistantAppsEnvironmentSettings _env =
      AssistantAppsEnvironmentSettings(
    assistantAppsApiUrl: 'https://api.assistantapps.com',
    assistantAppsAppGuid: '589405b4-e40f-4cd9-b793-6bf37944ee09',
    currentWhatIsNewGuid: '61ccc94c-d6c3-4820-80fe-d1238eab41f2',
    isProduction: false,
    patreonOAuthClientId: '',
  );

  @override
  void afterFirstLayout(BuildContext context) {
    initAssistantAppsDependencyInjection(
      _env,
      theme: StorybookThemeService(),
      guideApi: GuideApiService(),
    );

    getTranslations().load(const Locale('en'));

    setState(() {
      hasLoaded = true;
    });

    // Future.delayed(
    //   Duration(seconds: 0),
    //   () => setState(() {
    //     hasLoaded = true;
    //   }),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (hasLoaded == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Storybook(
      initialStory: StorybookNames.welcome,
      plugins: _plugins,
      showPanel: true,
      stories: [
        ...getHomeStories(),
        ...getAboutStories(),
        ...getSearchListStories(),
        ...getGuideStories(),
      ],
    );
  }
}
