enum SortDirection {
  None,
  Asc,
  Desc,
}

int sortDirectionTypeToInt(SortDirection type) {
  switch (type) {
    case SortDirection.None:
      return 0;
    case SortDirection.Asc:
      return 1;
    case SortDirection.Desc:
      return 2;
    default:
      return 0;
  }
}
