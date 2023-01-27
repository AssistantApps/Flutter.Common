import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../../contracts/enum/guideSectionItemType.dart';

Widget sectionListItem(BuildContext context, String text, List<Widget> widgets,
    {void Function()? onEdit,
    void Function()? onDelete,
    void Function()? moveUp,
    void Function()? moveDown}) {
  return SliverStickyHeader(
    header: sectionHeadingItem(
      context,
      text,
      onEdit: onEdit,
      onDelete: onDelete,
      moveUp: moveUp,
      moveDown: moveDown,
    ),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
        (c, i) => widgets[i],
        childCount: widgets.length,
      ),
    ),
  );
}

Widget sectionHeadingItem(BuildContext context, String text,
    {void Function()? onEdit,
    void Function()? onDelete,
    void Function()? moveUp,
    void Function()? moveDown}) {
  Widget? popupMenuWidget = popupMenu(context,
      onEdit: onEdit,
      onDelete: onDelete,
      iconColour: Colors.white,
      additionalItems: [
        if (moveUp != null) ...[
          PopupMenuActionItem(
            icon: Icons.arrow_upward,
            onPressed: moveUp,
            text: getTranslations().fromKey(LocaleKey.guideSectionMoveUp),
            sortOrder: 1,
          )
        ],
        if (moveDown != null) ...[
          PopupMenuActionItem(
            icon: Icons.arrow_downward,
            onPressed: moveDown,
            text: getTranslations().fromKey(LocaleKey.guideSectionMoveDown),
            sortOrder: 2,
          )
        ],
      ]);
  return Stack(
    children: [
      Container(
        height: 60.0,
        color: getTheme().getSecondaryColour(context),
        alignment: Alignment.center,
        margin: const EdgeInsets.all(0.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      if (popupMenuWidget != null) ...[
        Positioned(
          top: 4,
          right: 4,
          child: popupMenuWidget,
        ),
      ],
    ],
  );
}

Widget? getSectionItem(BuildContext context, GuideSectionItemViewModel item) {
  switch (item.type) {
    case GuideSectionItemType.text:
      return textListItem(item);
    case GuideSectionItemType.link:
      return linkListItem(item);
    case GuideSectionItemType.image:
      return imageListItem(context, item);
    case GuideSectionItemType.markdown:
      return markdownListItem(item);
    case GuideSectionItemType.table:
      return tableListItem(context, item);
    default:
      return null;
  }
}

Widget textListItem(GuideSectionItemViewModel item) => flatCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Text(
          item.content,
          maxLines: 2000,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );

Widget linkListItem(GuideSectionItemViewModel item) {
  onTap() => launchExternalURL(item.content);
  return flatCard(
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: getBaseWidget().appChip(
          label: Text(item.additionalContent ?? ''),
          backgroundColor: Colors.transparent,
          deleteIcon: const Icon(Icons.open_in_new),
          onDeleted: onTap,
        ),
      ),
    ),
  );
}

Widget imageListItem(context, GuideSectionItemViewModel item) {
  String imagePath = item.content;

  return InkWell(
    child: flatCard(child: networkImage(imagePath)),
    // onTap: () async {
    //   await navigateAsync(
    //     context,
    //     navigateTo: (context) => ImageViewerPage(item.name, imagePath),
    //   );
    // },
  );
}

Widget markdownListItem(GuideSectionItemViewModel item) {
  return flatCard(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: MarkdownBody(data: item.content),
    ),
  );
}

Widget tableListItem(context, GuideSectionItemViewModel item) {
  // var headingRowChildren = item.columns
  //     .map((c) => Padding(
  //         child: Text(
  //           c,
  //           style: TextStyle(fontWeight: FontWeight.w700),
  //         ),
  //         padding: const EdgeInsets.all(8.0)))
  //     .toList();

  List<TableRow> rows = List.empty(growable: true);
  // rows.add(TableRow(children: headingRowChildren));

  // for (var row in item.rows) {
  //   var rowChildren = List<Widget>();
  //   for (var colIndex = 0; colIndex < item.columns.length; colIndex++) {
  //     rowChildren.add(Padding(
  //       child: Text(row[colIndex]),
  //       padding: const EdgeInsets.all(8.0),
  //     ));
  //   }
  //   rows.add(TableRow(children: rowChildren));
  // }

  return flatCard(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        children: rows,
        border:
            TableBorder.all(width: 1, color: getTheme().getH1Colour(context)),
      ),
    ),
  );
}

Widget textItem(String text, {TextStyle? style}) => flatCard(
      child: ListTile(
        title: Text(
          text,
          maxLines: 2000,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      ),
    );
