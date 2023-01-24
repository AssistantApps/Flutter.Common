import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/types/listTypes.dart';
import '../searchable.dart';
import './listWithScrollbar.dart';

class SearchableList<T> extends StatelessWidget {
  final ListGetterType<T> listGetter;
  final ListGetterType<T>? backupListGetter;
  final ListItemDisplayerType<T>? listItemDisplayer;
  final ListItemWithIndexDisplayerType<T>? listItemWithIndexDisplayer;
  final ListItemSearchType<T>? listItemSearch;
  final void Function()? deleteAll;
  final LocaleKey? backupListWarningMessage;
  final int minListForSearch;
  final Widget? firstListItemWidget;
  final bool? keepFirstListItemWidgetVisible;
  final Widget? lastListItemWidget;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;

  const SearchableList(
    this.listGetter, {
    this.listItemSearch,
    this.listItemDisplayer,
    this.listItemWithIndexDisplayer,
    Key? key,
    this.firstListItemWidget,
    this.keepFirstListItemWidgetVisible,
    this.lastListItemWidget,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
    this.backupListGetter,
    this.backupListWarningMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Searchable<T>(
      listGetter,
      listWithScrollbar,
      backupListGetter: backupListGetter,
      itemDisplayer: listItemDisplayer,
      itemWithIndexDisplayer: listItemWithIndexDisplayer,
      //
      key: key,
      listItemSearch: listItemSearch,
      minListForSearch: minListForSearch,
      backupListWarningMessage: backupListWarningMessage,
      //
      firstListItemWidget: firstListItemWidget,
      keepFirstListItemWidgetVisible: keepFirstListItemWidgetVisible,
      lastListItemWidget: lastListItemWidget,
      //
      loadingText: loadingText,
      hintText: hintText,
      addFabPadding: addFabPadding,
      deleteAll: deleteAll,
    );
  }
}
