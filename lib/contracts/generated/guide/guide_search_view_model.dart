// To parse this JSON data, do
//
//     final stripeDonationViewModel = stripeDonationViewModelFromJson(jsonString);
//https://app.quicktype.io/

import 'dart:convert';

import '../../../helpers/stringHelper.dart';
import '../../../integration/dependencyInjection.dart';
import '../../enum/sort_direction.dart';

class GuideSearchViewModel {
  String appGuid;
  String? tag;
  String? name;
  SortDirection orderByName;
  SortDirection orderByDate;
  SortDirection orderByViews;
  SortDirection orderByLikes;
  int page;
  String? languageCode;

  GuideSearchViewModel({
    required this.appGuid,
    this.tag,
    this.name,
    required this.orderByName,
    required this.orderByDate,
    required this.orderByViews,
    required this.orderByLikes,
    required this.page,
    this.languageCode,
  });

  factory GuideSearchViewModel.defaultSearch() => GuideSearchViewModel(
        appGuid: getEnv().assistantAppsAppGuid,
        orderByName: SortDirection.none,
        orderByDate: SortDirection.none,
        orderByViews: SortDirection.none,
        orderByLikes: SortDirection.none,
        page: 1,
      );

  GuideSearchViewModel copyWith({
    String? appGuid,
    String? tag,
    String? name,
    SortDirection? orderByName,
    SortDirection? orderByDate,
    SortDirection? orderByViews,
    SortDirection? orderByLikes,
    int? page,
    String? languageCode,
  }) {
    return GuideSearchViewModel(
      appGuid: appGuid ?? this.appGuid,
      tag: tag ?? this.tag,
      name: name ?? this.name,
      orderByName: orderByName ?? this.orderByName,
      orderByDate: orderByDate ?? this.orderByDate,
      orderByViews: orderByViews ?? this.orderByViews,
      orderByLikes: orderByLikes ?? this.orderByLikes,
      page: page ?? this.page,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  String getHash() {
    return joinStringList([
      (appGuid),
      (tag ?? 'noTag'),
      (name ?? 'noName'),
      (sortDirectionTypeToInt(orderByName).toString()),
      (sortDirectionTypeToInt(orderByDate).toString()),
      (sortDirectionTypeToInt(orderByViews).toString()),
      (sortDirectionTypeToInt(orderByLikes).toString()),
      (page.toString()),
      (languageCode ?? '')
    ], '-');
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'AppGuid': appGuid,
        'Tag': tag,
        'Name': name,
        'OrderByName': sortDirectionTypeToInt(orderByName),
        'OrderByDate': sortDirectionTypeToInt(orderByDate),
        'OrderByViews': sortDirectionTypeToInt(orderByViews),
        'OrderByLikes': sortDirectionTypeToInt(orderByLikes),
        'Page': page,
        'LanguageCode': languageCode,
      };
}
