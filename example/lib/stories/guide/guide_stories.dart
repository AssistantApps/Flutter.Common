import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/storybook_names.dart';

List<Story> getGuideStories() {
  return [
    Story(
      name: StorybookNames.guidePage,
      description: 'Quick intro to this site',
      builder: (context) => GuideListPage(
        'analyticsKey',
        SettingsForGuideListPage(selectedLanguage: 'en'),
        draftModel: GuideDraftModel(
          selectedLanguage: '',
          deleteGuide: (_) {},
          updateGuide: (__) {},
        ),
      ),
    ),
    Story(
      name: StorybookNames.viewGuidePage,
      description: 'Quick intro to this site',
      builder: (context) => GuideViewPage(
        guideContentGuid: '',
      ),
    ),
    Story(
      name: StorybookNames.editGuidePage,
      description: 'Quick intro to this site',
      builder: (context) => GuideAddEditPage(
        GuideContentViewModel.newGuide(getNewGuid(), 'en'),
        List.empty(growable: true),
        draftModel: GuideDraftModel(
          selectedLanguage: '',
          deleteGuide: (_) {},
          updateGuide: (__) {},
        ),
        isEdit: false,
      ),
    ),
  ];
}
