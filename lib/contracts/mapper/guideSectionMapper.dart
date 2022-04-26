import 'package:flutter/widgets.dart';

import './guideSectionItemMapper.dart';
import '../generated/guide/guideSectionViewModel.dart';
import '../guide/guideSection.dart';

extension GuideSectionViewModelMapper on GuideSection {
  GuideSectionViewModel toViewModel() {
    return GuideSectionViewModel(
      guid: this.guid,
      heading: this.heading,
      items: this.items.map((item) => item.toViewModel()).toList(),
    );
  }
}

extension GuideSectionMapper on GuideSectionViewModel {
  GuideSection toDomain() {
    return GuideSection(
      guid: this.guid,
      heading: this.heading,
      headingTextController: TextEditingController(text: this.heading),
      items: this.items.map((item) => item.toDomain()).toList(),
    );
  }
}
