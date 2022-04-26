import 'package:after_layout/after_layout.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'services/themeService.dart';
import 'constants/StorybookNames.dart';
import 'stories/about/aboutStories.dart';
import 'stories/guide/guideStories.dart';
import 'stories/home/homeStories.dart';
import 'stories/searchList/searchListStories.dart';

void main() => runApp(StorybookApp());

final _plugins = initializePlugins(
  contentsSidePanel: true,
  knobsSidePanel: true,
  initialDeviceFrameData: DeviceFrameData(
    device: Devices.ios.iPhone13ProMax,
  ),
);

class StorybookApp extends StatefulWidget {
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
    initBaseDependencyInjection(
      _env,
      theme: StorybookThemeService(),
    );

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
    if (hasLoaded == false) return Center(child: CircularProgressIndicator());

    return Storybook(
      initialStory: StorybookNames.Welcome,
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
