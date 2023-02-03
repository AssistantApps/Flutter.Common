import 'package:flutter/widgets.dart';

import '../generated/guide/guide_section_item_view_model.dart';
import '../guide/guide_section_item.dart';

extension GuideSectionItemViewModelMapper on GuideSectionItem {
  GuideSectionItemViewModel toViewModel() {
    return GuideSectionItemViewModel(
      guid: guid,
      type: type,
      content: content ?? '',
      additionalContent: additionalContent ?? '',
      tableColumnNames: tableColumnNames ?? List.empty(),
      tableData: tableData ?? List.empty(),
    );
  }
}

extension GuideSectionItemMapper on GuideSectionItemViewModel {
  GuideSectionItem toDomain() {
    return GuideSectionItem(
      guid: guid,
      type: type,
      content: content,
      contentTextController: TextEditingController(text: content),
      additionalContent: additionalContent,
      additionalContentTextController:
          TextEditingController(text: additionalContent),
      tableColumnNames: tableColumnNames,
      tableData: tableData,
    );
  }
}
