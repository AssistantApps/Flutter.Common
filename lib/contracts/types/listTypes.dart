import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../results/paginationResultWithValue.dart';
import '../results/resultWithValue.dart';

typedef ListGetterType<T> = Future<ResultWithValue<List<T>>> Function();

typedef ListItemDisplayerType<T> = Widget Function(
  BuildContext ctx,
  T item, {
  void Function()? onTap,
});

typedef ListItemWithIndexDisplayerType<T> = Widget Function(
  BuildContext ctx,
  T item,
  int index, {
  void Function()? onTap,
});

typedef ListItemSearchType<T> = bool Function(
  T item,
  String searchTerm,
);

typedef ListOrGridDisplayType = Widget Function(
    { //
    required int itemCount,
    Key? key,
    required Widget Function(BuildContext, int) itemBuilder,
    int Function(Breakpoint)? gridViewColumnCalculator,
    bool? shrinkWrap,
    EdgeInsetsGeometry? padding,
    ScrollController? scrollController //
    });

typedef ListItemPaginationDisplayerType<T>
    = Future<PaginationResultWithValue<List<T>>> Function(int index);
