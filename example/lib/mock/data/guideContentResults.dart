import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/contracts/enum/adminApprovalStatus.dart';
import 'package:assistantapps_flutter_common/contracts/enum/guideSectionItemType.dart';

GuideContentViewModel sampleGuideContent1() => GuideContentViewModel(
      guid: getNewGuid(),
      title: 'How to do XYZ',
      subTitle: 'this is a subtitle',
      userName: 'KhaozTopsy',
      userGuid: getNewGuid(),
      languageCode: 'en',
      dateCreated: DateTime.parse('2022-04-25'),
      dateUpdated: DateTime.parse('2022-04-25'),
      views: 10,
      likes: 2,
      minutes: 20,
      showCreatedByUser: true,
      status: AdminApprovalStatus.Pending,
      tags: ['test', 'tag'],
      sections: [
        GuideSectionViewModel(
          guid: getNewGuid(),
          heading: 'section1',
          items: [
            GuideSectionItemViewModel(
              guid: getNewGuid(),
              content: 'This is a text',
              type: GuideSectionItemType.text,
            ),
            GuideSectionItemViewModel(
              guid: getNewGuid(),
              content: '# Markdown \n###Is **fun**!',
              type: GuideSectionItemType.markdown,
            ),
            GuideSectionItemViewModel(
              guid: getNewGuid(),
              content: 'https://google.com',
              additionalContent: 'google.com',
              type: GuideSectionItemType.link,
            ),
          ],
        ),
      ],
    );

GuideContentViewModel sampleGuideContent2() => GuideContentViewModel(
      guid: getNewGuid(),
      title: 'The best guide ever made',
      subTitle: 'this is a subtitle',
      userName: 'KhaozTopsy',
      userGuid: getNewGuid(),
      languageCode: 'en',
      dateCreated: DateTime.parse('2022-04-25'),
      dateUpdated: DateTime.parse('2022-04-25'),
      views: 10,
      likes: 2,
      minutes: 20,
      showCreatedByUser: true,
      status: AdminApprovalStatus.Pending,
      tags: ['test', 'tag'],
      sections: [
        GuideSectionViewModel(
          guid: getNewGuid(),
          heading: 'section1',
          items: [
            GuideSectionItemViewModel(
              guid: getNewGuid(),
              content: 'This is a text',
              type: GuideSectionItemType.text,
            ),
            GuideSectionItemViewModel(
              guid: getNewGuid(),
              content: '# Markdown \n###Is **fun**!',
              type: GuideSectionItemType.markdown,
            ),
          ],
        ),
      ],
    );
