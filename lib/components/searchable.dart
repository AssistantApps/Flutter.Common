import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../contracts/enum/locale_key.dart';
import '../contracts/results/result_with_value.dart';
import '../contracts/types/listTypes.dart';
import '../integration/dependencyInjection.dart';
import './adaptive/search_bar.dart';
import './common/animation.dart';
import './common/space.dart';

class Searchable<T> extends StatefulWidget {
  final ListGetterType<T> listGetter;
  final ListGetterType<T>? backupListGetter;
  final ListItemDisplayerType<T>? itemDisplayer;
  final ListItemWithIndexDisplayerType<T>? itemWithIndexDisplayer;
  final ListItemSearchType<T>? listItemSearch;
  final ListOrGridDisplayType listOrGridDisplay;
  final int Function(Breakpoint)? gridViewColumnCalculator;
  //
  final void Function()? deleteAll;
  final int minListForSearch;
  final LocaleKey? backupListWarningMessage;
  final Widget? firstListItemWidget;
  final bool? keepFirstListItemWidgetVisible;
  final Widget? lastListItemWidget;
  final String? hintText;
  final String? loadingText;
  final bool? addFabPadding;

  const Searchable(
    this.listGetter,
    this.listOrGridDisplay, {
    this.listItemSearch,
    this.itemDisplayer,
    this.itemWithIndexDisplayer,
    this.gridViewColumnCalculator,
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
  SearchableWidget<T> createState() => SearchableWidget<T>();
}

class SearchableWidget<T> extends State<Searchable<T>> {
  TextEditingController controller = TextEditingController();
  ScrollController listScrollController = ScrollController();
  final List<T> _searchResult = [];
  List<T> _listResults = [];
  bool hasLoaded = false;
  bool usingBackupGetter = false;

  SearchableWidget() {
    getLog().d("SearchableListWidget ctor");
  }

  @override
  void initState() {
    super.initState();

    getList();
  }

  Future<void> getList() async {
    final temp = await widget.listGetter();
    if (temp.isSuccess) {
      listSuccessFunc(temp);
      return;
    }

    if (widget.backupListGetter == null) {
      listErrorFunc();
      return;
    }

    final backupTemp = await widget.backupListGetter!();
    if (!backupTemp.isSuccess) {
      listErrorFunc();
      return;
    }
    listSuccessFunc(backupTemp, usingBackupGetter: true);
  }

  listSuccessFunc(ResultWithValue<List<T>> temp,
      {bool usingBackupGetter = false}) {
    List<T> tempResults = [];
    for (T item in temp.value) {
      tempResults.add(item);
    }

    if (mounted == false) return;
    setState(() {
      hasLoaded = true;
      this.usingBackupGetter = usingBackupGetter;
      _listResults = tempResults;
    });
  }

  listErrorFunc() {
    if (mounted == false) return;
    setState(() {
      hasLoaded = true;
      _listResults = [];
    });
  }

  Widget useItemDisplayer(BuildContext context, T data, int index) {
    if (widget.itemDisplayer != null) {
      return widget.itemDisplayer!(context, data);
    } else {
      return widget.itemWithIndexDisplayer!(context, data, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded) {
      if (widget.keepFirstListItemWidgetVisible == true &&
          widget.firstListItemWidget != null) {
        return Column(
          children: [
            SearchBar(
              controller: controller,
              hintText: widget.hintText,
              onSearchTextChanged: onSearchTextChanged,
            ),
            widget.firstListItemWidget!,
            Expanded(
              child: Center(
                child: getLoading().smallLoadingIndicator(),
              ),
            ),
          ],
        );
      }
      return getLoading().fullPageLoading(context,
          loadingText: widget.loadingText ??
              getTranslations().fromKey(LocaleKey.loading));
    }

    List<Widget> columnWidgets = List.empty(growable: true);
    if (_listResults.length > widget.minListForSearch) {
      columnWidgets.add(
        SearchBar(
          controller: controller,
          hintText: widget.hintText,
          onSearchTextChanged: onSearchTextChanged,
        ),
      );
    }

    if (this.usingBackupGetter && widget.backupListWarningMessage != null) {
      columnWidgets.add(
        Container(
          color: Colors.red,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4),
            child: Text(
              getTranslations().fromKey(widget.backupListWarningMessage!),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    if (_searchResult.isEmpty && controller.text.isNotEmpty ||
        _listResults.isEmpty && controller.text.isEmpty) {
      List<Widget> noItemsList = List.empty(growable: true);
      if (widget.firstListItemWidget != null) {
        noItemsList.add(widget.firstListItemWidget!);
      }
      noItemsList.add(
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 30),
          child: Text(
            getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      );
      columnWidgets.add(Column(children: noItemsList));
    } else {
      List<T> list = (_searchResult.isNotEmpty || controller.text.isNotEmpty)
          ? _searchResult
          : _listResults;

      List<Widget> additionalWidgets = List.empty(growable: true);
      if (widget.deleteAll != null) {
        additionalWidgets.add(deleteAllButton(context));
      }
      if (widget.addFabPadding ?? false) {
        additionalWidgets.add(const EmptySpace10x());
      }
      if (widget.lastListItemWidget != null) {
        additionalWidgets.add(widget.lastListItemWidget!);
      }

      int listLength = list.length + additionalWidgets.length;
      if (widget.firstListItemWidget != null) listLength++;

      columnWidgets.add(Expanded(
        child: widget.listOrGridDisplay(
          scrollController: listScrollController,
          gridViewColumnCalculator: widget.gridViewColumnCalculator,
          itemCount: listLength,
          itemBuilder: (context, index) {
            if (widget.firstListItemWidget != null) {
              if (index == 0) return widget.firstListItemWidget!;
              index = index - 1;
            }
            if (index >= list.length) {
              int modifier = (widget.firstListItemWidget != null) ? 2 : 1;
              return additionalWidgets[listLength - index - modifier];
            }
            return useItemDisplayer(context, list[index], index);
          },
        ),
      ));
    }

    return animateWidgetIn(
      key: widget.key,
      child: Column(key: widget.key, children: columnWidgets),
    );
  }

  Widget deleteAllButton(context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: MaterialButton(
        color: Colors.red,
        onPressed: () => widget.deleteAll!(),
        child: Text(getTranslations().fromKey(LocaleKey.deleteAll)),
      ),
    );
  }

  onSearchTextChanged(String searchText) async {
    _searchResult.clear();
    if (searchText.isEmpty) {
      if (mounted == false) return;
      setState(() {});
      return;
    }

    for (T item in _listResults) {
      if (widget.listItemSearch == null ||
          widget.listItemSearch!(item, searchText.toLowerCase())) {
        _searchResult.add(item);
      }
    }

    if (mounted == false) return;
    setState(() {});
  }
}
