import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/StorybookNames.dart';

List<Story> getGuideStories() {
  return [
    Story(
      name: StorybookNames.GuidePage,
      description: 'Quick intro to this site',
      builder: (context) => GuideListPage(
        'analyticsKey',
        SettingsForGuideListPage(selectedLanguage: 'en'),
      ),
    ),
    Story(
      name: StorybookNames.ViewGuidePage,
      description: 'Quick intro to this site',
      builder: (context) => GuideViewPage(
        guideContentGuid: '',
      ),
    ),
  ];
}
