// To parse this JSON data, do
//
//     final stripeDonationViewModel = stripeDonationViewModelFromJson(jsonString);
//https://app.quicktype.io/

import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'guideSectionItemViewModel.dart';

class GuideSectionViewModel {
  String guid;
  String heading;
  List<GuideSectionItemViewModel> items;

  GuideSectionViewModel({
    required this.guid,
    required this.heading,
    required this.items,
  });

  factory GuideSectionViewModel.fromRawJson(String str) =>
      GuideSectionViewModel.fromJson(json.decode(str));

  factory GuideSectionViewModel.fromJson(Map<String, dynamic> json) =>
      GuideSectionViewModel(
        guid: readStringSafe(json, 'guid'),
        heading: readStringSafe(json, 'heading'),
        items: readListSafe(
          json,
          'items',
          (dynamic innerJson) => GuideSectionItemViewModel.fromJson(innerJson),
        ),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'guid': guid,
        'heading': heading,
        'items': items.map((i) => i.toJson()).toList(),
      };
}
