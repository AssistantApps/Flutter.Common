import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

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
  createState() => SearchableWidget<T>();
}

class SearchableWidget<T> extends State<Searchable<T>> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
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

  Widget useItemDisplayer(BuildContext itemCtx, T data, int index) {
    if (widget.itemDisplayer != null) {
      return widget.itemDisplayer!(itemCtx, data);
    } else {
      return widget.itemWithIndexDisplayer!(itemCtx, data, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    KeyedSubtree searchBarWidget = KeyedSubtree(
      key: const Key('searchBar'),
      child: AdaptiveSearchBar(
        controller: _controller,
        hintText: widget.hintText,
        onSearchTextChanged: onSearchTextChanged,
      ),
    );

    if (!hasLoaded) {
      if (widget.keepFirstListItemWidgetVisible == true &&
          widget.firstListItemWidget != null) {
        return Column(
          children: [
            searchBarWidget,
            widget.firstListItemWidget!,
            Expanded(
              child: Center(
                child: getLoading().smallLoadingIndicator(),
              ),
            ),
          ],
        );
      }
      return getLoading().fullPageLoading(
        context,
        loadingText:
            widget.loadingText ?? getTranslations().fromKey(LocaleKey.loading),
      );
    }

    List<Widget> columnWidgets = List.empty(growable: true);
    if (_listResults.length > widget.minListForSearch) {
      columnWidgets.add(searchBarWidget);
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

    if (_searchResult.isEmpty && _controller.text.isNotEmpty ||
        _listResults.isEmpty && _controller.text.isEmpty) {
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
      List<T> list = (_searchResult.isNotEmpty || _controller.text.isNotEmpty)
          ? _searchResult
          : _listResults;

      List<Widget> additionalWidgets = List.empty(growable: true);
      if (widget.deleteAll != null) {
        additionalWidgets.add(deleteAllButton());
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
          scrollController: _listScrollController,
          gridViewColumnCalculator: widget.gridViewColumnCalculator,
          itemCount: listLength,
          itemBuilder: (itemCtx, index) {
            if (widget.firstListItemWidget != null) {
              if (index == 0) return widget.firstListItemWidget!;
              index = index - 1;
            }
            if (index >= list.length) {
              int modifier = (widget.firstListItemWidget != null) ? 2 : 1;
              return additionalWidgets[listLength - index - modifier];
            }
            return useItemDisplayer(itemCtx, list[index], index);
          },
        ),
      ));
    }

    Widget column = Column(key: widget.key, children: columnWidgets);

    if (isDesktop) return column;

    return Listener(
      child: column,
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget deleteAllButton() {
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

  @override
  void dispose() {
    _controller.dispose();
    _listScrollController.dispose();
    super.dispose();
  }
}
