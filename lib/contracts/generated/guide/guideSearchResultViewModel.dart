// To parse this JSON data, do
//
//     final guideSearchResultViewModel = guideSearchResultViewModelFromJson(jsonString);

import 'dart:convert';

import '../../../helpers/jsonHelper.dart';
import '../../enum/admin_approval_status.dart';

class GuideSearchResultViewModel {
  String guid;
  String guideDetailGuid;
  String title;
  String subTitle;
  bool showCreatedByUser;
  String userGuid;
  String userName;
  String? translatorGuid;
  String? translatorName;
  int minutes;
  List<String> tags;
  AdminApprovalStatus status;
  String languageCode;
  int version;
  DateTime dateCreated;

  GuideSearchResultViewModel({
    required this.guid,
    required this.guideDetailGuid,
    required this.title,
    required this.subTitle,
    required this.showCreatedByUser,
    required this.userGuid,
    required this.userName,
    this.translatorGuid,
    this.translatorName,
    required this.minutes,
    required this.tags,
    required this.status,
    required this.languageCode,
    required this.version,
    required this.dateCreated,
  });

  factory GuideSearchResultViewModel.fromRawJson(String str) =>
      GuideSearchResultViewModel.fromJson(json.decode(str));

  factory GuideSearchResultViewModel.fromJson(Map<String, dynamic> json) =>
      GuideSearchResultViewModel(
        guid: readStringSafe(json, 'guid'),
        guideDetailGuid: readStringSafe(json, 'guideDetailGuid'),
        title: readStringSafe(json, 'title'),
        subTitle: readStringSafe(json, 'subTitle'),
        showCreatedByUser: readBoolSafe(json, 'showCreatedByUser'),
        userGuid: readStringSafe(json, 'userGuid'),
        userName: readStringSafe(json, 'userName'),
        translatorGuid: readStringSafe(json, 'translatorGuid'),
        translatorName: readStringSafe(json, 'translatorName'),
        minutes: readIntSafe(json, 'minutes'),
        tags: readListSafe(
            json, 'tags', (dynamic innerJson) => innerJson.toString()),
        status: AdminApprovalStatus.values[readIntSafe(json, 'status')],
        languageCode: readStringSafe(json, 'languageCode'),
        version: readIntSafe(json, 'version'),
        dateCreated: readDateSafe(json, 'dateCreated'),
      );
}
