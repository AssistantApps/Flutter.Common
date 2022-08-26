import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';
import '../common/image.dart';
import './button.dart';

Widget paginationControl(BuildContext context, int currentPage, int totalPages,
        Function() next, Function() prev) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (currentPage > 1) ...[
          Center(child: positiveButton(context, title: '<', onPress: prev))
        ],
        if (currentPage < totalPages) ...[
          Center(child: positiveButton(context, title: '>', onPress: next))
        ],
      ],
    );

Widget smallLoadMorePageButton(BuildContext context) => smallPageButton(context,
    getTranslations().fromKey(LocaleKey.loadMore), Icons.navigate_next);

Widget smallPageButton(BuildContext context, String title, IconData icon) {
  return ListTile(
    leading: getCorrectlySizedImageFromIcon(context, icon),
    title: Text(title),
  );
}
