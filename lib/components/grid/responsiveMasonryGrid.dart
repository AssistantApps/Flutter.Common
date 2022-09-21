import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../helpers/columnHelper.dart';

Widget responsiveMasonryGrid(
  Widget Function(BuildContext itemCtx, int index) itemBuilder,
  int Function(Breakpoint breakpoint)? columnCountFunc,
) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: BreakpointBuilder(
      builder: (BuildContext innerContext, Breakpoint breakpoint) {
        int numCols = (columnCountFunc == null)
            ? getCustomColumnCount(breakpoint)
            : columnCountFunc(breakpoint);

        return MasonryGridView.count(
          key: Key("masonryGrid-col-$numCols"),
          crossAxisCount: numCols,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          itemBuilder: itemBuilder,
        );
      },
    ),
  );
}
