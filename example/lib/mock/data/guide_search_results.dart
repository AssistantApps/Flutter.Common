import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:assistantapps_flutter_common/contracts/enum/adminApprovalStatus.dart';

final sampleGuideGuid1 = getNewGuid();
final sampleGuideGuidContent1 = getNewGuid();
GuideSearchResultViewModel sampleGuide1() => GuideSearchResultViewModel(
      guid: sampleGuideGuid1,
      title: 'This is that best guide ever',
      subTitle: 'this is a subtitle',
      userName: 'KhaozTopsy',
      userGuid: getNewGuid(),
      languageCode: 'en',
      dateCreated: DateTime.parse('2022-04-25'),
      guideDetailGuid: sampleGuideGuidContent1,
      minutes: 20,
      showCreatedByUser: true,
      status: AdminApprovalStatus.pending,
      tags: ['test', 'tag'],
      version: 3,
    );

final sampleGuideGuid2 = getNewGuid();
final sampleGuideGuidContent2 = getNewGuid();
GuideSearchResultViewModel sampleGuide2() => GuideSearchResultViewModel(
      guid: sampleGuideGuid2,
      title: 'This is that best guide ever v2',
      subTitle: 'this is a subtitle v2',
      userName: 'KhaozTopsy',
      userGuid: getNewGuid(),
      languageCode: 'en',
      dateCreated: DateTime.parse('2022-04-25'),
      guideDetailGuid: sampleGuideGuidContent2,
      minutes: 20,
      showCreatedByUser: true,
      status: AdminApprovalStatus.pending,
      tags: ['test', 'tag'],
      version: 3,
    );
