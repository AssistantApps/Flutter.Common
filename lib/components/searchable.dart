import 'package:flutter/material.dart';

import '../contracts/enum/localeKey.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import 'adaptive/searchBar.dart';
import 'common/animation.dart';
import 'common/space.dart';

class Searchable<T> extends StatefulWidget {
  final Future<ResultWithValue<List<T>>> Function() listGetter;
  final Future<ResultWithValue<List<T>>> Function()? backupListGetter;
  //
  final Widget Function(BuildContext, T)? itemDisplayer;
  final Widget Function(BuildContext, T, int)? itemWithIndexDisplayer;
  final Widget Function(
      { //
      required int itemCount,
      Key? key,
      required Widget Function(BuildContext, int) itemBuilder,
      bool? shrinkWrap,
      EdgeInsetsGeometry? padding,
      ScrollController? scrollController //
      }) listOrGridDisplay;
  //
  final bool Function(T, String)? listItemSearch;
  final void Function()? deleteAll;
  final int minListForSearch;
  final Key? key;
  final LocaleKey? backupListWarningMessage;
  final Widget? firstListItemWidget;
  final bool? keepFirstListItemWidgetVisible;
  final Widget? lastListItemWidget;
  final String? hintText;
  final String? loadingText;
  final bool? addFabPadding;

  Searchable(
    this.listGetter,
    this.listOrGridDisplay, {
    this.listItemSearch,
    this.itemDisplayer,
    this.itemWithIndexDisplayer,
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
  SearchableWidget<T> createState() => SearchableWidget<T>();
}

class SearchableWidget<T> extends State<Searchable<T>> {
  TextEditingController controller = TextEditingController();
  List<T> _searchResult = [];
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

  Future<Null> getList() async {
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
            searchBar(
                context, controller, widget.hintText, onSearchTextChanged),
            widget.firstListItemWidget!,
            Expanded(
              child: Center(child: getLoading().smallLoadingIndicator()),
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
        searchBar(context, controller, widget.hintText, onSearchTextChanged),
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
              getTranslations().fromKey(widget.backupListWarningMessage!),
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
        noItemsList.add(widget.firstListItemWidget!);
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
      if (widget.deleteAll != null) {
        additionalWidgets.add(deleteAllButton(context));
      }
      if (widget.addFabPadding ?? false) {
        additionalWidgets.add(emptySpace10x());
      }
      if (widget.lastListItemWidget != null) {
        additionalWidgets.add(widget.lastListItemWidget!);
      }

      int listLength = list.length + additionalWidgets.length;
      if (widget.firstListItemWidget != null) listLength++;

      columnWidgets.add(Expanded(
        child: widget.listOrGridDisplay(
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
      child: MaterialButton(
        child: Text(getTranslations().fromKey(LocaleKey.deleteAll)),
        color: Colors.red,
        onPressed: () => widget.deleteAll!(),
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
      if (widget.listItemSearch == null ||
          widget.listItemSearch!(item, searchText.toLowerCase())) {
        _searchResult.add(item);
      }
    });

    if (mounted == false) return;
    setState(() {});
  }
}
