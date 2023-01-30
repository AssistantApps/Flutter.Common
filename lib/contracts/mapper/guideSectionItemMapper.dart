import 'package:flutter/widgets.dart';

import '../generated/guide/guideSectionItemViewModel.dart';
import '../guide/guideSectionItem.dart';

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
