import 'package:flutter/widgets.dart';

import '../generated/guide/guideSectionItemViewModel.dart';
import '../guide/guideSectionItem.dart';

extension GuideSectionItemViewModelMapper on GuideSectionItem {
  GuideSectionItemViewModel toViewModel() {
    return GuideSectionItemViewModel(
      guid: this.guid,
      type: this.type,
      content: this.content ?? '',
      additionalContent: this.additionalContent ?? '',
      tableColumnNames: this.tableColumnNames ?? List.empty(),
      tableData: this.tableData ?? List.empty(),
    );
  }
}

extension GuideSectionItemMapper on GuideSectionItemViewModel {
  GuideSectionItem toDomain() {
    return GuideSectionItem(
      guid: this.guid,
      type: this.type,
      content: this.content,
      contentTextController: TextEditingController(text: this.content),
      additionalContent: this.additionalContent,
      additionalContentTextController:
          TextEditingController(text: this.additionalContent),
      tableColumnNames: this.tableColumnNames,
      tableData: this.tableData,
    );
  }
}
