import 'package:flutter/material.dart';

import '../common/image.dart';
import 'button.dart';

Widget paginationControl(
        int currentPage, int totalPages, Function next, Function prev) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (currentPage > 1) ...[
          Center(child: positiveButton(title: '<', onPress: prev))
        ],
        if (currentPage < totalPages) ...[
          Center(child: positiveButton(title: '>', onPress: next))
        ],
      ],
    );

Widget smallLoadMorePageButton(
        BuildContext context, String loadMore, Color colour) =>
    smallPageButton(context, loadMore, Icons.navigate_next, colour);

Widget smallPageButton(
    BuildContext context, String title, IconData icon, Color colour) {
  return ListTile(
    leading: getCorrectlySizedImageFromIcon(context, icon, colour),
    title: Text(title),
  );
}
