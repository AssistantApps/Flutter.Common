// To parse this JSON data, do
//
//     final stripeDonationViewModel = stripeDonationViewModelFromJson(jsonString);
//https://app.quicktype.io/

import 'dart:convert';

import '../../../helpers/json_helper.dart';
import './guide_content_view_model.dart';
import './guide_section_view_model.dart';

class AddGuideViewModel {
  String guid;
  String appGuid;
  String title;
  String subTitle;
  bool showCreatedByUser;
  String languageCode;
  int minutes;
  List<String> tags;
  List<GuideSectionViewModel> sections;

  AddGuideViewModel({
    required this.guid,
    required this.appGuid,
    required this.title,
    required this.subTitle,
    required this.showCreatedByUser,
    required this.languageCode,
    required this.minutes,
    required this.tags,
    required this.sections,
  });

  factory AddGuideViewModel.fromGuideDetails(
    GuideContentViewModel orig, {
    List<GuideSectionViewModel>? sections,
    required String appGuid,
  }) {
    return AddGuideViewModel(
      guid: orig.guid,
      appGuid: appGuid,
      title: orig.title,
      subTitle: orig.subTitle,
      showCreatedByUser: orig.showCreatedByUser,
      languageCode: orig.languageCode,
      minutes: orig.minutes,
      tags: orig.tags,
      sections: sections ?? List.empty(),
    );
  }

  factory AddGuideViewModel.fromJson(Map<String, dynamic> json) =>
      AddGuideViewModel(
        guid: readStringSafe(json, 'guid'),
        appGuid: readStringSafe(json, 'appGuid'),
        title: readStringSafe(json, 'title'),
        subTitle: readStringSafe(json, 'subTitle'),
        showCreatedByUser: readBoolSafe(json, 'showCreatedByUser'),
        languageCode: readStringSafe(json, 'languageCode'),
        minutes: readIntSafe(json, 'minutes'),
        tags: readListSafe(
            json, 'tags', (dynamic innerJson) => innerJson.toString()),
        sections: readListSafe(json, 'sections',
            (dynamic innerJson) => GuideSectionViewModel.fromJson(innerJson)),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'appGuid': appGuid,
        'title': title,
        'subTitle': subTitle,
        'showCreatedByUser': showCreatedByUser,
        'languageCode': languageCode,
        'minutes': minutes,
        'tags': tags, //.map((t) => t).toList(),
        'sections': sections.map((s) => s.toJson()).toList(),
      };
}
