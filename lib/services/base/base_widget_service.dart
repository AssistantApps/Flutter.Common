import 'package:flutter/material.dart';

import '../../components/adaptive/app_bar.dart';
import '../../components/adaptive/app_bar_for_sub_page.dart';
import '../../components/adaptive/checkbox.dart';
import '../../components/adaptive/chip.dart';
import '../../components/adaptive/app_scaffold.dart';
import '../../components/common/badge.dart';
import '../../contracts/misc/action_item.dart';
import '../../helpers/device_helper.dart';
import '../../integration/dependency_injection_base.dart';
import './interface/i_base_widget_service.dart';

class BaseWidgetService implements IBaseWidgetService {
  @override
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
      AdaptiveAppScaffold(
        appBar: appBar,
        body: body,
        builder: builder,
        drawer: drawer,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );

  @override
  Widget appBar(
    BuildContext context,
    Widget title,
    List<Widget> actions, {
    Widget? leading,
    PreferredSizeWidget? bottom,
  }) =>
      AdaptiveAppBar(
        title: title,
        actions: actions,
        leading: leading,
        bottom: bottom,
      );

  @override
  PreferredSizeWidget appBarForSubPage(
    BuildContext context, {
    Widget? title,
    List<ActionItem>? actions,
    List<ActionItem>? shortcutActions,
    bool showHomeAction = false,
    bool showBackAction = true,
  }) {
    if (actions == null || actions.isEmpty) {
      actions = List.empty(growable: true);
    }
    if (showHomeAction) {
      actions.add(
        ActionItem(
          icon: Icons.home,
          onPressed: () async =>
              await getNavigation().navigateHomeAsync(context),
        ),
      );
    }
    return AdaptiveAppBarForSubPage(
      title,
      actions,
      showHomeAction,
      showBackAction,
      shortcutActions,
    );
  }

  @override
  Widget appChip({
    Key? key,
    String? text,
    Widget? label,
    TextStyle? style,
    EdgeInsets? labelPadding,
    double? elevation,
    EdgeInsets? padding,
    Color? shadowColor,
    Icon? deleteIcon,
    void Function()? onDeleted,
    void Function()? onTap,
    Color backgroundColor = Colors.white,
  }) =>
      AdaptiveChip(
        key: key,
        text: text,
        label: label,
        style: style,
        labelPadding: labelPadding,
        elevation: elevation,
        padding: padding,
        shadowColor: shadowColor,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
        onTap: onTap,
        backgroundColor: backgroundColor,
      );

  @override
  Widget adaptiveCheckbox({
    Key? key,
    required bool value,
    required void Function(bool newValue) onChanged,
    Color? activeColor,
  }) =>
      AdaptiveCheckbox(
        key: key,
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      );

  @override
  Widget basicBadge({
    Key? key,
    required String text,
    required Widget? child,
  }) =>
      BasicBadge(
        key: key,
        text: text,
        child: child,
      );

  @override
  Widget customDivider() => isWeb
      ? Divider(thickness: .5, color: Colors.grey[600])
      : Divider(color: Colors.grey[600]);
}
