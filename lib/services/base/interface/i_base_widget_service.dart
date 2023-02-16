import 'package:assistantapps_flutter_common/contracts/misc/action_item.dart';
import 'package:flutter/material.dart';

import '../../../components/adaptive/checkbox.dart';
import '../../../components/adaptive/chip.dart';
import '../../../components/common/badge.dart';

class IBaseWidgetService {
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
      Container();

  Widget appBar(
    BuildContext context,
    Widget title,
    List<Widget> actions, {
    Widget? leading,
    PreferredSizeWidget? bottom,
  }) =>
      Container();

  PreferredSizeWidget appBarForSubPage(
    BuildContext context, {
    Widget? title,
    List<ActionItem>? actions,
    List<ActionItem>? shortcutActions,
    bool showHomeAction = false,
    bool showBackAction = true,
  }) =>
      AppBar();

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

  Widget basicBadge({
    Key? key,
    required String text,
    required Widget? child,
    Color? textColour,
  }) =>
      BasicBadge(
        key: key,
        text: text,
        textColour: textColour,
        child: child,
      );

  Widget customDivider() => Divider(color: Colors.grey[600]);
}
