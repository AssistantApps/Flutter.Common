import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/results/paginationResultWithValue.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import './searchable_list.dart';

class PaginationSearchableList<T> extends StatefulWidget {
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      listGetter;
  final Future<ResultWithValue<List<T>>> Function()? backupListGetter;
  final LocaleKey? backupListWarningMessage;
  final Widget Function(BuildContext context, T, {void Function()? onTap})
      listItemDisplayer;
  final bool Function(T, String) listItemSearch;
  final void Function()? deleteAll;
  final int minListForSearch;
  final String? customKey;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;
  final bool useGridView;
  final int Function(Breakpoint)? gridViewColumnCalculator;
  final Widget? firstListItemWidget;
  final Widget? lastListItemWidget;

  const PaginationSearchableList(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch, {
    Key? key,
    this.customKey,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch = 10,
    this.addFabPadding = false,
    this.useGridView = false,
    this.gridViewColumnCalculator,
    this.backupListGetter,
    this.backupListWarningMessage,
    this.firstListItemWidget,
    this.lastListItemWidget,
  }) : super(key: key);
  @override
  PaginationSearchableListWidget<T> createState() =>
      // ignore: no_logic_in_create_state
      PaginationSearchableListWidget<T>(
        listGetter,
        listItemDisplayer,
        listItemSearch,
        customKey,
        hintText,
        loadingText,
        minListForSearch,
        addFabPadding,
      );
}

class PaginationSearchableListWidget<T>
    extends State<PaginationSearchableList<T>> {
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      listGetter;
  int currentPage = 1;
  int totalPages = 1;
  final Widget Function(BuildContext context, T, {void Function()? onTap})
      listItemDisplayer;
  final bool Function(T, String) listItemSearch;
  final int minListForSearch;
  final String? customKey;
  final String? hintText;
  final String? loadingText;
  final bool addFabPadding;

  PaginationSearchableListWidget(
    this.listGetter,
    this.listItemDisplayer,
    this.listItemSearch,
    this.customKey,
    this.hintText,
    this.loadingText,
    this.minListForSearch,
    this.addFabPadding,
  ) {
    getLog().d("SearchableListWidget ctor");
  }

  Future<ResultWithValue<List<T>>> hookIntoListGetter() async {
    final temp = await listGetter(this.currentPage);
    if (temp.isSuccess) {
      setState(() {
        currentPage = temp.currentPage;
        totalPages = temp.totalPages;
      });
      return ResultWithValue<List<T>>(true, temp.value, '');
    }
    return ResultWithValue<List<T>>(false, temp.value, temp.errorMessage);
  }

  void nextPage() {
    setState(() {
      currentPage = this.currentPage + 1;
    });
  }

  void prevPage() {
    setState(() {
      currentPage = this.currentPage - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    InkWell firstListItemWidget = InkWell(
      onTap: prevPage,
      child: widget.firstListItemWidget,
    );
    InkWell lastListItemWidget = InkWell(
      onTap: nextPage,
      child: widget.lastListItemWidget,
    );
    return SearchableList<T>(
      () => hookIntoListGetter(),
      listItemDisplayer: listItemDisplayer,
      listItemSearch: listItemSearch,
      minListForSearch: minListForSearch,
      // useGridView: widget.useGridView,
      // gridViewColumnCalculator: widget.gridViewColumnCalculator,
      addFabPadding: widget.addFabPadding,
      backupListGetter: widget.backupListGetter,
      backupListWarningMessage: widget.backupListWarningMessage,
      deleteAll: widget.deleteAll,
      hintText: widget.hintText,
      loadingText: widget.loadingText,
      key: Key('${widget.key}-$currentPage'),
      firstListItemWidget:
          (currentPage > 1 && widget.firstListItemWidget != null)
              ? firstListItemWidget
              : null,
      lastListItemWidget:
          (currentPage < totalPages && widget.lastListItemWidget != null)
              ? lastListItemWidget
              : null,
    );
  }
}
