import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../assistantapps_flutter_common.dart';
import '../searchable.dart';

class SearchableList<T> extends StatelessWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Future<ResultWithValue<List<T>>> Function()? backupListGetter;
  final Widget Function(BuildContext, T)? listItemDisplayer;
  final Widget Function(BuildContext, T, int)? listItemWithIndexDisplayer;
  final bool Function(T, String)? listItemSearch;
  final void Function()? deleteAll;
  final LocaleKey? backupListWarningMessage;
  final int minListForSearch;
  final Key? key;
  final Widget? firstListItemWidget;
  final Widget? lastListItemWidget;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;

  SearchableList(
    this.listGetter, {
    this.listItemSearch,
    this.listItemDisplayer,
    this.listItemWithIndexDisplayer,
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

  @override
  Widget build(BuildContext context) {
    return Searchable(
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
      lastListItemWidget: lastListItemWidget,
      //
      loadingText: loadingText,
      hintText: hintText,
      addFabPadding: addFabPadding,
      deleteAll: deleteAll,
    );
  }
}
