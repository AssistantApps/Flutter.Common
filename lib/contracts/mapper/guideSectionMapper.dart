import 'package:flutter/widgets.dart';

import './guideSectionItemMapper.dart';
import '../generated/guide/guide_section_view_model.dart';
import '../guide/guide_section.dart';

extension GuideSectionViewModelMapper on GuideSection {
  GuideSectionViewModel toViewModel() {
    return GuideSectionViewModel(
      guid: guid,
      heading: heading,
      items: items.map((item) => item.toViewModel()).toList(),
    );
  }
}

extension GuideSectionMapper on GuideSectionViewModel {
  GuideSection toDomain() {
    return GuideSection(
      guid: guid,
      heading: heading,
      headingTextController: TextEditingController(text: heading),
      items: items.map((item) => item.toDomain()).toList(),
    );
  }
}
