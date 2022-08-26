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
  final preferredSize;
  final bottom;
  final backgroundColor;
  static final kMinInteractiveDimensionCupertino = 44.0;

  AppBarForSubPage(this.title, this.actions, this.showHomeAction,
      this.showBackAction, this.shortcutActions,
      {this.bottom, this.backgroundColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super();

  @override
  Widget build(BuildContext context) =>
      _appBarForAndroid(context, title, actions, shortcutActions);

  Widget _appBarForAndroid(context, Widget? title, List<ActionItem> actions,
      List<ActionItem>? shortcutActions) {
    List<Widget> actionWidgets = List.empty(growable: true);
    return adaptiveAppBar(context, title, actionWidgets,
        leading: this.showBackAction
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async =>
                    await getNavigation().navigateBackOrHomeAsync(context),
              )
            : null);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

PreferredSizeWidget adaptiveAppBarForSubPageHelper(
  context, {
  Widget? title,
  List<ActionItem>? actions,
  List<ActionItem>? shortcutActions,
  bool showHomeAction = false,
  bool showBackAction = true,
}) {
  if (actions == null || actions.length == 0) {
    actions = List.empty(growable: true);
  }
  if (showHomeAction) {
    actions.add(ActionItem(
        icon: Icons.home,
        onPressed: () async =>
            await getNavigation().navigateHomeAsync(context)));
  }
  return AppBarForSubPage(
      title, actions, showHomeAction, showBackAction, shortcutActions);
}
