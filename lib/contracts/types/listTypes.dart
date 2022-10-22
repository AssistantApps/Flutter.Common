import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../results/paginationResultWithValue.dart';
import '../results/resultWithValue.dart';

typedef Future<ResultWithValue<List<T>>> ListGetterType<T>();

typedef Widget ListItemDisplayerType<T>(
  BuildContext ctx,
  T item, {
  void Function()? onTap,
});

typedef Widget ListItemWithIndexDisplayerType<T>(
  BuildContext ctx,
  T item,
  int index, {
  void Function()? onTap,
});

typedef bool ListItemSearchType<T>(
  T item,
  String searchTerm,
);

typedef Widget ListOrGridDisplayType(
    { //
    required int itemCount,
    Key? key,
    required Widget Function(BuildContext, int) itemBuilder,
    int Function(Breakpoint)? gridViewColumnCalculator,
    bool? shrinkWrap,
    EdgeInsetsGeometry? padding,
    ScrollController? scrollController //
    });

typedef Future<
    PaginationResultWithValue<
        List<T>>> ListItemPaginationDisplayerType<T>(int index);
