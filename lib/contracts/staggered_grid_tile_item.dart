import 'package:flutter/material.dart';

class StaggeredGridTileItem {
  final int columns;
  final int rows;
  final Widget child;

  StaggeredGridTileItem(
    this.columns,
    this.rows,
    this.child,
  );
}
