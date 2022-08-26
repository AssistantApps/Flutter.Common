import 'package:flutter/material.dart';

import '../../components/adaptive/appBar.dart';
import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../contracts/misc/actionItem.dart';
import './interface/IBaseWidgetService.dart';

class BaseWidgetService implements IBaseWidgetService {
  Widget appScaffold(
    BuildContext context, {
    required PreferredSizeWidget appBar,
    Widget? body,
    Widget Function(BuildContext scaffoldContext)? builder,
    Widget? drawer,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
  }) =>
      adaptiveAppScaffold(
        context,
        appBar: appBar,
        body: body,
        builder: builder,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );

  Widget appBar(BuildContext context, Widget title, List<Widget> actions,
          {Widget? leading, PreferredSizeWidget? bottom}) =>
      adaptiveAppBar(context, title, actions, leading: leading, bottom: bottom);

  PreferredSizeWidget appBarForSubPage(
    BuildContext context, {
    Widget? title,
    List<ActionItem>? actions,
    List<ActionItem>? shortcutActions,
    bool showHomeAction = false,
    bool showBackAction = true,
  }) =>
      adaptiveAppBarForSubPageHelper(
        context,
        title: title,
        actions: actions,
        shortcutActions: shortcutActions,
        showBackAction: showBackAction,
        showHomeAction: showHomeAction,
      );
}
