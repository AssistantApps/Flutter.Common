enum GuideSectionItemType {
  text,
  link,
  image,
  markdown,
  table,
}

int guideSectionItemTypeToInt(GuideSectionItemType type) {
  switch (type) {
    case GuideSectionItemType.text:
      return 0;
    case GuideSectionItemType.link:
      return 1;
    case GuideSectionItemType.image:
      return 2;
    case GuideSectionItemType.markdown:
      return 2;
    case GuideSectionItemType.table:
      return 2;
    default:
      return 0;
  }
}
