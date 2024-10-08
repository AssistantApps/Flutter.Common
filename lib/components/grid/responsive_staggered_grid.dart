import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../contracts/staggered_grid_tile_item.dart';
import '../../helpers/column_helper.dart';

class ResponsiveStaggeredGrid extends StatelessWidget {
  final List<StaggeredGridTileItem> items;
  final int Function(Breakpoint breakpoint)? columnCountFunc;

  const ResponsiveStaggeredGrid({
    super.key,
    required this.items,
    this.columnCountFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
          int numCols = (columnCountFunc == null)
              ? getCustomColumnCount(breakpoint)
              : columnCountFunc!(breakpoint);
          return StaggeredGrid.count(
            key: Key("staggeredGrid-col-$numCols"),
            crossAxisCount: numCols,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: items
                .map(
                  (item) => StaggeredGridTile.count(
                    crossAxisCellCount: item.columns,
                    mainAxisCellCount: item.rows,
                    child: item.child,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
