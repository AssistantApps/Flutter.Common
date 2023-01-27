import 'package:assistantapps_flutter_common/contracts/misc/actionItem.dart';
import 'package:flutter/material.dart';

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
      Chip(
        key: key,
        label: Text(text ?? '...'),
        labelPadding: labelPadding,
        elevation: elevation,
        padding: padding,
        shadowColor: shadowColor,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
        backgroundColor: backgroundColor,
      );
}
