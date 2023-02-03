import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contracts/misc/action_item.dart';
import '../../helpers/device_helper.dart';
import '../../integration/dependency_injection.dart';
import '../common/action_item.dart';
import './app_bar.dart';
import 'shortcut_action_button.dart';

class AdaptiveAppBarForSubPage extends StatelessWidget
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

  AdaptiveAppBarForSubPage(
    this.title,
    this.actions,
    this.showHomeAction,
    this.showBackAction,
    this.shortcutActions, {
    Key? key,
    this.bottom,
    this.backgroundColor,
  })  : preferredSize = Size.fromHeight(
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

    List<Widget> actionWidgets = List.empty(growable: true);

    if (shortcutActions != null && shortcutActions!.isNotEmpty) {
      actionWidgets.add(
        ShortcutActionButton(shortcutActions!),
      );
    }
    actionWidgets.addAll(actionItemToAndroidAction(context, actions));

    if (showHomeAction) {
      actionWidgets.addAll(
        actionItemToAndroidAction(context, [goHomeAction(context)]),
      );
    }

    return AdaptiveAppBar(
      title: title,
      actions: actionWidgets,
      leading: leadingWidget,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
