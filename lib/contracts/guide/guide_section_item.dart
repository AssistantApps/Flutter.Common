import 'package:flutter/cupertino.dart';

import '../enum/guide_section_item_type.dart';

class GuideSectionItem {
  String guid;
  GuideSectionItemType type;
  String? content;
  TextEditingController contentTextController;
  String? additionalContent;
  TextEditingController additionalContentTextController;
  List<String>? tableColumnNames;
  List<TextEditingController>? tableColumnNameTextController;
  List<List<String>>? tableData;
  List<List<TextEditingController>>? tableDataTextController;
  int? sortOrder;

  GuideSectionItem({
    required this.guid,
    required this.type,
    this.content,
    required this.contentTextController,
    this.additionalContent,
    required this.additionalContentTextController,
    this.tableColumnNames,
    this.tableColumnNameTextController,
    this.tableData,
    this.tableDataTextController,
    this.sortOrder,
  });

  GuideSectionItem copyWith({
    String? guid,
    GuideSectionItemType? type,
    String? content,
    TextEditingController? contentTextController,
    String? additionalContent,
    TextEditingController? additionalContentTextController,
    List<String>? tableColumnNames,
    List<TextEditingController>? tableColumnNameTextController,
    List<List<String>>? tableData,
    List<List<TextEditingController>>? tableDataTextController,
    int? sortOrder,
  }) {
    return GuideSectionItem(
      guid: guid ?? this.guid,
      type: type ?? this.type,
      content: content ?? this.content,
      contentTextController:
          contentTextController ?? this.contentTextController,
      additionalContent: additionalContent ?? this.additionalContent,
      additionalContentTextController: additionalContentTextController ??
          this.additionalContentTextController,
      tableColumnNames: tableColumnNames ?? this.tableColumnNames,
      tableColumnNameTextController:
          tableColumnNameTextController ?? this.tableColumnNameTextController,
      tableData: tableData ?? this.tableData,
      tableDataTextController:
          tableDataTextController ?? this.tableDataTextController,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
