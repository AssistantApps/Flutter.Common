import 'package:flutter/material.dart';

import '../../integration/dependency_injection.dart';

class AdaptiveAppBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const AdaptiveAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      centerTitle: true,
      actions: actions,
      backgroundColor: getTheme().getPrimaryColour(context),
      foregroundColor: getTheme().getTextColour(context),
      bottom: bottom,
      scrolledUnderElevation: 0,
    );
  }
}
