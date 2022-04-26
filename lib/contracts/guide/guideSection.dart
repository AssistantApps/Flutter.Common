import 'package:flutter/cupertino.dart';

import 'guideSectionItem.dart';

class GuideSection {
  String guid;
  String heading;
  TextEditingController headingTextController;
  List<GuideSectionItem> items;
  int? sortOrder;

  GuideSection({
    required this.guid,
    required this.heading,
    required this.headingTextController,
    required this.items,
    this.sortOrder,
  });
}
