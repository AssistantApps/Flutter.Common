import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../contracts/enum/localeKey.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import 'adaptive/searchBar.dart';
import 'common/space.dart';

class Searchable<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Future<ResultWithValue<List<T>>> Function() backupListGetter;
  //
  final Widget Function(BuildContext, T) itemDisplayer;
  final Widget Function(BuildContext, T, int) itemWithIndexDisplayer;
  final Widget Function({
    Key key,
    int itemCount,
    bool shrinkWrap,
    Widget Function(BuildContext, int) itemBuilder,
  }) listOrGridDisplay;
  //
  final bool Function(T, String) listItemSearch;
  final void Function() deleteAll;
  final int minListForSearch;
  final Key key;
  final LocaleKey backupListWarningMessage;
  final Widget firstListItemWidget;
  final Widget lastListItemWidget;
  final String hintText;
  final String loadingText;
  final bool addFabPadding;

  Searchable(
    this.listGetter,
    this.listOrGridDisplay, {
    this.listItemSearch,
    this.itemDisplayer,
    this.itemWithIndexDisplayer,
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
  SearchableWidget<T> createState() => SearchableWidget<T>(
        listGetter(),
        itemDisplayer,
        itemWithIndexDisplayer,
        listOrGridDisplay,
        listItemSearch,
        key,
        hintText,
        loadingText,
        deleteAll,
        minListForSearch,
        addFabPadding,
      );
}

class SearchableWidget<T> extends State<Searchable<T>> {
  TextEditingController controller = TextEditingController();
  Future<ResultWithValue<List<T>>> listGetter;
  //
  final Widget Function(BuildContext context, T) itemDisplayer;
  final Widget Function(BuildContext, T, int) itemWithIndexDisplayer;
  final Widget Function({
    int itemCount,
    Key key,
    Widget Function(BuildContext, int) itemBuilder,
  }) listOrGridDisplay;
  //
  final bool Function(T, String) listItemSearch;
  final void Function() deleteAll;
  List<T> _searchResult = [];
  List<T> _listResults = [];
  int minListForSearch;
  Key key;
  bool hasLoaded = false;
  bool usingBackupGetter = false;
  String hintText;
  String loadingText;
  final bool addFabPadding;

  SearchableWidget(
    this.listGetter,
    this.itemDisplayer,
    this.itemWithIndexDisplayer,
    this.listOrGridDisplay,
    this.listItemSearch,
    this.key,
    this.hintText,
    this.loadingText,
    this.deleteAll,
    this.minListForSearch,
    this.addFabPadding,
  ) {
    getLog().d("SearchableListWidget ctor");
  }

  @override
  void initState() {
    super.initState();

    getList();
  }

  Future<Null> getList() async {
    final temp = await listGetter;
    if (temp.isSuccess) {
      listSuccessFunc(temp);
      return;
    }

    if (widget.backupListGetter == null) {
      listErrorFunc();
      return;
    }

    final backupTemp = await widget.backupListGetter();
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
    if (itemDisplayer != null) {
      return itemDisplayer(context, data);
    } else {
      return itemWithIndexDisplayer(context, data, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded)
      return getLoading().fullPageLoading(context,
          loadingText:
              loadingText ?? getTranslations().fromKey(LocaleKey.loading));

    List<Widget> columnWidgets = List.empty(growable: true);
    if (_listResults.length > minListForSearch) {
      columnWidgets.add(
        searchBar(context, controller, hintText, onSearchTextChanged),
      );
    }

    if (this.usingBackupGetter && widget.backupListWarningMessage != null) {
      columnWidgets.add(
        Container(
          color: Colors.red,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 4, bottom: 4),
            child: Text(
              getTranslations().fromKey(widget.backupListWarningMessage),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    if (_searchResult.length == 0 && controller.text.isNotEmpty ||
        _listResults.length == 0 && controller.text.isEmpty) {
      List<Widget> noItemsList = List.empty(growable: true);
      if (widget.firstListItemWidget != null) {
        noItemsList.add(widget.firstListItemWidget);
      }
      noItemsList.add(
        Container(
          child: Text(
            getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          width: double.infinity,
          margin: EdgeInsets.only(top: 30),
        ),
      );
      columnWidgets.add(Column(children: noItemsList));
    } else {
      List<T> list = (_searchResult.length != 0 || controller.text.isNotEmpty)
          ? _searchResult
          : _listResults;

      List<Widget> additionalWidgets = List.empty(growable: true);
      if (deleteAll != null) {
        additionalWidgets.add(deleteAllButton(context));
      }
      if (addFabPadding) {
        additionalWidgets.add(emptySpace10x());
      }
      if (widget.lastListItemWidget != null) {
        additionalWidgets.add(widget.lastListItemWidget);
      }

      int listLength = list.length + additionalWidgets.length;
      if (widget.firstListItemWidget != null) listLength++;

      columnWidgets.add(Expanded(
        child: listOrGridDisplay(
          itemCount: listLength,
          itemBuilder: (context, index) {
            if (widget.firstListItemWidget != null) {
              if (index == 0) return widget.firstListItemWidget;
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

    return Column(key: key, children: columnWidgets);
  }

  Widget deleteAllButton(context) {
    return Container(
      child: MaterialButton(
        child: Text(getTranslations().fromKey(LocaleKey.deleteAll)),
        color: Colors.red,
        onPressed: () => deleteAll(),
      ),
      margin: EdgeInsets.all(4),
    );
  }

  onSearchTextChanged(String searchText) async {
    _searchResult.clear();
    if (searchText.isEmpty) {
      if (mounted == false) return;
      setState(() {});
      return;
    }

    _listResults.forEach((item) {
      if (listItemSearch == null ||
          listItemSearch(item, searchText.toLowerCase())) {
        _searchResult.add(item);
      }
    });

    if (mounted == false) return;
    setState(() {});
  }
}
