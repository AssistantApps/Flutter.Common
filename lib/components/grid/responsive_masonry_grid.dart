import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../helpers/column_helper.dart';

class ResponsiveMasonryGrid extends StatelessWidget {
  final Widget Function(BuildContext itemCtx, int index) itemBuilder;
  final int Function(Breakpoint breakpoint)? columnCountFunc;

  const ResponsiveMasonryGrid(
    this.itemBuilder,
    this.columnCountFunc, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
          int numCols = (columnCountFunc == null)
              ? getCustomColumnCount(breakpoint)
              : columnCountFunc!(breakpoint);

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
}
