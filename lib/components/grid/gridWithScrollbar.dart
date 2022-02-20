import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../helpers/columnHelper.dart';
import '../../helpers/deviceHelper.dart';

Widget gridWithScrollbar({
  required int itemCount,
  Key? key,
  required Widget Function(BuildContext, int) itemBuilder,
  int Function(Breakpoint)? gridViewColumnCalculator,
  EdgeInsetsGeometry? padding,
  bool shrinkWrap = true,
  ScrollController? scrollController,
}) =>
    BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
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
      StaggeredGridView listView = StaggeredGridView.countBuilder(
        primary: false,
        shrinkWrap: true,
        padding: padding ?? const EdgeInsets.all(8),
        physics: isiOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        controller: scrollController,
        key: Key('grid-cross-axis$crossAxisCount'),
      );
      return isiOS
          ? appleGridWithScrollbar(itemCount: itemCount, listView: listView)
          : androidGridWithScrollbar(itemCount: itemCount, listView: listView);
    });

Widget androidGridWithScrollbar({int? itemCount, required Widget listView}) =>
    Scrollbar(
      child: listView,
    );

Widget appleGridWithScrollbar({int? itemCount, required Widget listView}) =>
    CupertinoScrollbar(
      child: listView,
    );
