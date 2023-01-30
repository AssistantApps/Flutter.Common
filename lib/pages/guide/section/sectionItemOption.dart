import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../../contracts/enum/guideSectionItemType.dart';

class SectionItemOption {
  GuideSectionItemType type;
  LocaleKey titleLocale;
  IconData icon;

  SectionItemOption({
    required this.type,
    required this.titleLocale,
    required this.icon,
  });
}

List<SectionItemOption> availableSectionTypes = [
  SectionItemOption(
    type: GuideSectionItemType.text,
    titleLocale: LocaleKey.guideSectionAddText,
    icon: Icons.text_fields,
  ),
  SectionItemOption(
    type: GuideSectionItemType.link,
    titleLocale: LocaleKey.guideSectionAddLink,
    icon: Icons.link,
  ),
  SectionItemOption(
    type: GuideSectionItemType.image,
    titleLocale: LocaleKey.guideSectionAddImage,
    icon: Icons.image,
  ),
  SectionItemOption(
    type: GuideSectionItemType.markdown,
    titleLocale: LocaleKey.guideSectionAddMarkdown,
    icon: Icons.text_format,
  ),
  // SectionItemOption(
  //   type: GuideSectionItemType.table,
  //   titleLocale: LocaleKey.title,
  //   icon: Icons.table_view,
  // ),
];

Widget sectionItemOptionTilePresenter(BuildContext context,
        SectionItemOption item, void Function(GuideSectionItemType) onTap) =>
    InkWell(
      child: Card(
        margin: const EdgeInsets.all(4),
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(item.icon, size: 48),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  getTranslations().fromKey(item.titleLocale),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => onTap(item.type),
    );
