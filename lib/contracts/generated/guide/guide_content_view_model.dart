// To parse this JSON data, do
//
//     final guideContentViewModel = guideContentViewModelFromJson(jsonString);

import 'dart:convert';

import '../../../helpers/json_helper.dart';
import '../../enum/admin_approval_status.dart';
import './add_guide_view_model.dart';
import './guide_section_view_model.dart';

class GuideContentViewModel {
  GuideContentViewModel({
    required this.guid,
    required this.title,
    required this.subTitle,
    this.likes = 0,
    this.views = 0,
    this.showCreatedByUser = true,
    this.userGuid,
    this.userName,
    required this.languageCode,
    required this.minutes,
    required this.tags,
    this.originalGuideGuid,
    this.translatorGuid,
    required this.status,
    required this.dateCreated,
    required this.dateUpdated,
    required this.sections,
  });

  String guid;
  String title;
  String subTitle;
  int likes;
  int views;
  bool showCreatedByUser;
  String? userGuid;
  String? userName;
  String languageCode;
  int minutes;
  List<String> tags;
  String? originalGuideGuid;
  String? translatorGuid;
  AdminApprovalStatus status;
  DateTime dateCreated;
  DateTime dateUpdated;
  List<GuideSectionViewModel> sections;

  factory GuideContentViewModel.fromAddGuide(AddGuideViewModel orig) {
    return GuideContentViewModel(
      guid: orig.guid,
      title: orig.title,
      subTitle: orig.subTitle,
      showCreatedByUser: orig.showCreatedByUser,
      languageCode: orig.languageCode,
      minutes: orig.minutes,
      tags: orig.tags,
      status: AdminApprovalStatus.pending,
      dateUpdated: DateTime.now(),
      dateCreated: DateTime.now(),
      sections: orig.sections,
    );
  }

  factory GuideContentViewModel.newGuide(String guid, String langCode) {
    return GuideContentViewModel(
      guid: guid,
      title: '',
      subTitle: '',
      showCreatedByUser: false,
      languageCode: langCode,
      minutes: 0,
      tags: [],
      status: AdminApprovalStatus.pending,
      dateUpdated: DateTime.now(),
      dateCreated: DateTime.now(),
      sections: [],
    );
  }

  GuideContentViewModel copyWith({
    String? guid,
    String? title,
    String? subTitle,
    int? likes,
    int? views,
    bool? showCreatedByUser,
    String? userGuid,
    String? userName,
    String? languageCode,
    int? minutes,
    List<String>? tags,
    String? originalGuideGuid,
    String? translatorGuid,
    AdminApprovalStatus? status,
    DateTime? dateCreated,
    DateTime? dateUpdated,
    List<GuideSectionViewModel>? sections,
  }) {
    return GuideContentViewModel(
      guid: guid ?? this.guid,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      showCreatedByUser: showCreatedByUser ?? this.showCreatedByUser,
      userGuid: userGuid ?? this.userGuid,
      userName: userName ?? this.userName,
      languageCode: languageCode ?? this.languageCode,
      minutes: minutes ?? this.minutes,
      tags: tags ?? this.tags,
      originalGuideGuid: originalGuideGuid ?? this.originalGuideGuid,
      translatorGuid: translatorGuid ?? this.translatorGuid,
      status: status ?? this.status,
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      sections: sections ?? this.sections,
    );
  }

  factory GuideContentViewModel.fromRawJson(String str) =>
      GuideContentViewModel.fromJson(json.decode(str));

  factory GuideContentViewModel.fromJson(Map<String, dynamic> json) =>
      GuideContentViewModel(
        guid: readStringSafe(json, 'guid'),
        title: readStringSafe(json, 'title'),
        subTitle: readStringSafe(json, 'subTitle'),
        // bannerImageData: UploadedImageViewModel.fromJson(
        //   json['bannerImageData'],
        // ),
        likes: readIntSafe(json, 'likes'),
        views: readIntSafe(json, 'views'),
        showCreatedByUser: readBoolSafe(json, 'showCreatedByUser'),
        userGuid: readStringSafe(json, 'userGuid'),
        userName: readStringSafe(json, 'userName'),
        languageCode: readStringSafe(json, 'languageCode'),
        minutes: readIntSafe(json, 'minutes'),
        tags: readListSafe(json, 'tags', (x) => x.toString()),
        originalGuideGuid: readStringSafe(json, 'originalGuideGuid'),
        translatorGuid: readStringSafe(json, 'translatorGuid'),
        // ignore: collection_methods_unrelated_type
        status: adminApprovalStatusValues.map[readIntSafe(json, 'status')] ??
            AdminApprovalStatus.pending,
        dateCreated: readDateSafe(json, 'dateCreated'),
        dateUpdated: readDateSafe(json, 'dateUpdated'),
        sections: readListSafe(
          json,
          'sections',
          (x) => GuideSectionViewModel.fromJson(x),
        ),
      );
}
