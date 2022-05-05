import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';

import '../../contracts/results/paginationResultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../common/animation.dart';

class LazyLoadSearchableList<T extends dynamic> extends StatefulWidget {
  final Future<PaginationResultWithValue<List<T>>> Function(int page)
      listGetter;
  final Future<PaginationResultWithValue<List<T>>> Function(int page)?
      backupListGetter;
  final int pageSize;
  final Widget Function(BuildContext, T)? listItemDisplayer;
  final Widget Function(BuildContext, T, int, int)? listItemWithIndexDisplayer;
  final String? customKey;
  final String? hintText;
  final String? loadingText;
  final bool? addFabPadding;
  final Widget? loadMoreItemWidget;
  final String? errorMessage;
  final String? emptyMessage;

  LazyLoadSearchableList(
    this.listGetter,
    this.pageSize, {
    this.listItemDisplayer,
    this.listItemWithIndexDisplayer,
    this.customKey,
    this.backupListGetter,
    this.hintText,
    this.loadingText,
    this.addFabPadding = false,
    this.loadMoreItemWidget,
    this.errorMessage,
    this.emptyMessage,
  });
  @override
  _LazyLoadSearchableListWidget<T> createState() =>
      _LazyLoadSearchableListWidget<T>();
}

class _LazyLoadSearchableListWidget<T extends dynamic>
    extends State<LazyLoadSearchableList<T>> {
  ScrollController _scrollController = ScrollController();
  List<int> fetchedPages = List.empty(growable: true);
  int totalPages = 1;
  int totalRows = 0;
  // bool usingBackupGetter = false;

  _LazyLoadSearchableListWidget();

  Future<List<T>> getMoreData(int page) async {
    int pageToGet = (page ~/ widget.pageSize) + 1;
    if (pageToGet < 1 || pageToGet > totalPages) return [];
    if (fetchedPages.contains(pageToGet)) return [];

    PaginationResultWithValue<List<T>> temp =
        await widget.listGetter(pageToGet);
    if (temp.isSuccess && mounted) {
      getLog().d('getMoreData' + temp.isSuccess.toString());
      this.setState(() {
        fetchedPages.add(temp.currentPage);
        totalPages = temp.totalPages;
      });
      return temp.value;
    }

    if (widget.backupListGetter != null && mounted) {
      getLog().d('backup getMoreData' + temp.isSuccess.toString());
      PaginationResultWithValue<List<T>> tempBackup =
          await widget.backupListGetter!(pageToGet);
      if (tempBackup.isSuccess) {
        this.setState(() {
          fetchedPages.add(tempBackup.currentPage);
          totalPages = tempBackup.totalPages;
          totalRows = totalRows + tempBackup.value.length;
          // usingBackupGetter = true;
        });
        return tempBackup.value;
      }
    }

    getLog().d('getMoreData List.empty');
    // List<Null> result = List.empty();
    // return result;
    return List.empty();
  }

  Widget useItemDisplayer(BuildContext context, T data, int index) {
    if (widget.listItemDisplayer != null) {
      return widget.listItemDisplayer!(context, data);
    } else {
      return widget.listItemWithIndexDisplayer!(
        context,
        data,
        index,
        totalRows,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<T> prefetch = List.empty(growable: true);
    return animateWidgetIn(
      key: Key('lazyLoaded-anim'),
      child: PaginationView<T>(
        preloadedItems: prefetch,
        itemBuilder: (BuildContext innerCtxt, T user, int index) =>
            useItemDisplayer(innerCtxt, user, index),
        paginationViewType: PaginationViewType.listView,
        pageFetch: getMoreData,
        onError: (dynamic error) => Center(
          child: Text(widget.errorMessage ?? 'Some error occured'),
        ),
        onEmpty: Center(
          child: Text(widget.emptyMessage ?? 'Sorry! This is empty'),
        ),
        bottomLoader: Center(child: getLoading().smallLoadingTile(context)),
        initialLoader: getLoading().fullPageLoading(context),
        scrollController: _scrollController,
        key: Key('lazyLoaded'),
      ),
    );
  }
}
