import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../searchable.dart';

class SearchableGrid<T> extends StatelessWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Future<ResultWithValue<List<T>>> Function()? backupListGetter;
  final Widget Function(BuildContext, T)? gridItemDisplayer;
  final Widget Function(BuildContext, T, int)? gridItemWithIndexDisplayer;
  final int Function(Breakpoint)? gridViewColumnCalculator;
  //
  final bool Function(T, String)? gridItemSearch;
  final void Function()? deleteAll;
  final LocaleKey? backupListWarningMessage;
  final int minListForSearch;
  final Key? key;
  final Widget? firstListItemWidget;
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
    this.lastListItemWidget,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
    this.backupListGetter,
    this.backupListWarningMessage,
  });

  Widget localGridWithScrollbar(
      { //
      required int itemCount,
      Key? key,
      required Widget Function(BuildContext, int) itemBuilder,
      bool? shrinkWrap,
      EdgeInsetsGeometry? padding,
      ScrollController? scrollController //
      }) {
    return gridWithScrollbar(
      key: key,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      gridViewColumnCalculator: gridViewColumnCalculator,
      scrollController: scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Searchable(
      listGetter,
      localGridWithScrollbar,
      backupListGetter: backupListGetter,
      itemDisplayer: gridItemDisplayer,
      itemWithIndexDisplayer: gridItemWithIndexDisplayer,
      //
      key: key,
      listItemSearch: gridItemSearch,
      minListForSearch: minListForSearch,
      backupListWarningMessage: backupListWarningMessage,
      //
      firstListItemWidget: firstListItemWidget,
      lastListItemWidget: lastListItemWidget,
      //
      loadingText: loadingText,
      hintText: hintText,
      addFabPadding: addFabPadding,
      deleteAll: deleteAll,
    );
  }
}
