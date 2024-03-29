import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../contracts/types/list_types.dart';
import '../../helpers/column_helper.dart';
import '../../helpers/device_helper.dart';

ListOrGridDisplayType gridWithScrollbar = (
    { //
    required int itemCount,
    Key? key,
    required Widget Function(BuildContext, int) itemBuilder,
    int Function(Breakpoint)? gridViewColumnCalculator,
    bool? shrinkWrap,
    EdgeInsetsGeometry? padding,
    ScrollController? scrollController //
    }) {
  return BreakpointBuilder(builder: (
    BuildContext innerContext,
    Breakpoint breakpoint,
  ) {
    int Function(Breakpoint p1) columnCalc =
        gridViewColumnCalculator ?? getCustomColumnCount;
    int crossAxisCount = columnCalc(breakpoint);
    // var listView = GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: crossAxisCount,
    //   ),
    //   shrinkWrap: shrinkWrap,
    //   padding: const EdgeInsets.all(8),
    //   physics: isiOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
    //   itemCount: itemCount,
    //   itemBuilder: itemBuilder,
    //   key: Key('grid-cross-axis$crossAxisCount'),
    // );

    StaggeredGrid stagGrid = StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      key: Key('grid-cross-axis$crossAxisCount'),
      children: List.filled(itemCount, 1)
          .asMap()
          .entries
          .map((entry) => itemBuilder(innerContext, entry.key))
          .toList(),
    );

    // ListView listView = ListView(
    //   primary: false,
    //   shrinkWrap: true,
    //   padding: padding ?? const EdgeInsets.all(8),
    //   physics: isiOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
    //   controller: scrollController,
    //   key: Key('list-grid-cross-axis$crossAxisCount'),
    //   children: [stagGrid],
    // );

    return isiOS
        ? appleGridWithScrollbar(itemCount: itemCount, stagGrid: stagGrid)
        : androidGridWithScrollbar(itemCount: itemCount, stagGrid: stagGrid);
  });
};

Widget androidGridWithScrollbar(
        {int? itemCount, required StaggeredGrid stagGrid}) =>
    Scrollbar(
        child: SingleChildScrollView(
      child: Scrollbar(child: stagGrid),
    ));

Widget appleGridWithScrollbar(
        {int? itemCount, required StaggeredGrid stagGrid}) =>
    Scrollbar(
        child: SingleChildScrollView(
      child: CupertinoScrollbar(child: stagGrid),
    ));
