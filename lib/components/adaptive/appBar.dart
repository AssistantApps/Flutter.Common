import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

Widget adaptiveAppBar(context, Widget? title, List<Widget> actions,
    {Widget? leading, PreferredSizeWidget? bottom}) {
  return AppBar(
    leading: leading,
    title: title,
    centerTitle: true,
    actions: actions,
    backgroundColor: getTheme().getPrimaryColour(context),
    bottom: bottom,
  );
}
