import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contracts/types/listTypes.dart';
import '../../helpers/deviceHelper.dart';

ListOrGridDisplayType listWithScrollbar = (
    { //
    required int itemCount,
    Key? key,
    required Widget Function(BuildContext, int) itemBuilder,
    int Function(Breakpoint)? gridViewColumnCalculator,
    bool? shrinkWrap,
    EdgeInsetsGeometry? padding,
    ScrollController? scrollController //
    }) {
  ListView listView = ListView.builder(
    primary: false,
    // physics: isApple ? BouncingScrollPhysics() : ClampingScrollPhysics(),
    physics: const AlwaysScrollableScrollPhysics(),
    key: key,
    padding: padding,
    shrinkWrap: shrinkWrap ?? false,
    itemCount: itemCount,
    itemBuilder: itemBuilder,
    controller: scrollController,
  );
  return isApple
      ? appleListWithScrollbar(
          listView: listView,
          scrollController: scrollController,
        )
      : androidListWithScrollbar(
          listView: listView,
          scrollController: scrollController,
        );
};

Widget androidListWithScrollbar({
  required Widget listView,
  ScrollController? scrollController,
}) =>
    Scrollbar(
      controller: scrollController,
      child: listView,
    );

Widget appleListWithScrollbar({
  required Widget listView,
  ScrollController? scrollController,
}) =>
    CupertinoScrollbar(
      controller: scrollController,
      child: listView,
    );
