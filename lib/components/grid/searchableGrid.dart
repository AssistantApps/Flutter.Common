import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/types/listTypes.dart';
import '../searchable.dart';
import './gridWithScrollbar.dart';

class SearchableGrid<T> extends StatelessWidget {
  final ListGetterType<T> listGetter;
  final ListGetterType<T>? backupListGetter;
  final ListItemDisplayerType<T>? gridItemDisplayer;
  final ListItemWithIndexDisplayerType<T>? gridItemWithIndexDisplayer;
  final ListItemSearchType<T>? gridItemSearch;
  //
  final int Function(Breakpoint)? gridViewColumnCalculator;
  final void Function()? deleteAll;
  final LocaleKey? backupListWarningMessage;
  final int minListForSearch;
  final Key? key;
  final Widget? firstListItemWidget;
  final bool? keepFirstListItemWidgetVisible;
  final Widget? lastListItemWidget;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;

  SearchableGrid(
    this.listGetter, {
    this.gridItemSearch,
    this.gridItemDisplayer,
    this.gridItemWithIndexDisplayer,
    this.gridViewColumnCalculator,
    this.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Searchable(
      listGetter,
      gridWithScrollbar,
      backupListGetter: backupListGetter,
      itemDisplayer: gridItemDisplayer,
      itemWithIndexDisplayer: gridItemWithIndexDisplayer,
      gridViewColumnCalculator: gridViewColumnCalculator,
      //
      key: key,
      listItemSearch: gridItemSearch,
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
