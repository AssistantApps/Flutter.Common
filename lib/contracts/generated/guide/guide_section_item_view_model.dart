// To parse this JSON data, do
//
//     final stripeDonationViewModel = stripeDonationViewModelFromJson(jsonString);
//https://app.quicktype.io/

import 'dart:convert';

import '../../../helpers/json_helper.dart';
import '../../enum/guide_section_item_type.dart';

class GuideSectionItemViewModel {
  String guid;
  GuideSectionItemType type;
  String content;
  String? additionalContent;
  List<String>? tableColumnNames;
  List<List<String>>? tableData;

  GuideSectionItemViewModel({
    required this.guid,
    required this.type,
    required this.content,
    this.additionalContent,
    this.tableColumnNames,
    this.tableData,
  });

  factory GuideSectionItemViewModel.fromRawJson(String str) =>
      GuideSectionItemViewModel.fromJson(json.decode(str));

  factory GuideSectionItemViewModel.fromJson(Map<String, dynamic> json) =>
      GuideSectionItemViewModel(
        guid: readStringSafe(json, 'guid'),
        type: GuideSectionItemType.values[readIntSafe(json, 'type')],
        content: readStringSafe(json, 'content'),
        additionalContent: readStringSafe(json, 'additionalContent'),
        tableColumnNames: readListSafe(json, 'tableColumnNames',
            (dynamic innerJson) => innerJson.toString()),
        tableData: readListSafe(
          json,
          'tableData',
          (dynamic innerJson) =>
              (innerJson as List).map((inner) => inner.toString()).toList(),
        ).toList(),
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'guid': guid,
        'type': guideSectionItemTypeToInt(type),
        'content': content,
        'additionalContent': additionalContent,
        'tableColumnNames': tableColumnNames,
        'tableData': tableData,
      };
}
