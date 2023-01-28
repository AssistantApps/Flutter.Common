import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contracts/misc/actionItem.dart';
import '../../integration/dependencyInjection.dart';
import './appBar.dart';

class AppBarForSubPage extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final Widget? title;
  final List<ActionItem> actions;
  final List<ActionItem>? shortcutActions;
  final bool showHomeAction;
  final bool showBackAction;
  @override
  final Size preferredSize;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  static const kMinInteractiveDimensionCupertino = 44.0;

  AppBarForSubPage(this.title, this.actions, this.showHomeAction,
      this.showBackAction, this.shortcutActions,
      {Key? key, this.bottom, this.backgroundColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    IconButton? leadingWidget = showBackAction
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async =>
                await getNavigation().navigateBackOrHomeAsync(context),
          )
        : null;

    return AdaptiveAppBar(
      title: title,
      actions: List.empty(),
      leading: leadingWidget,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
