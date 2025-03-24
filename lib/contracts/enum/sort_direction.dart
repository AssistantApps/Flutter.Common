enum SortDirection {
  none,
  asc,
  desc,
}

int sortDirectionTypeToInt(SortDirection type) {
  switch (type) {
    case SortDirection.none:
      return 0;
    case SortDirection.asc:
      return 1;
    case SortDirection.desc:
      return 2;
  }
}
