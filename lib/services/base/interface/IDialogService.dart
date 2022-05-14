import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/search/dropdownOption.dart';

class IDialogService {
  //
  void showSimpleDialog(
    context,
    String title,
    Widget content, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  void showSimpleHelpDialog(
    context,
    String title,
    String helpContent, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  Widget simpleDialogCloseButton(
    context, {
    Function()? onTap,
  }) =>
      Container();

  Widget simpleDialogPositiveButton(
    context, {
    LocaleKey? title,
    Function? onTap,
  }) =>
      Container();

  void showOptionsDialog(
    context,
    String title,
    List<DropdownOption> options, {
    String selectedValue = '',
    Function(BuildContext ctx, String value)? onSuccess,
  }) {}

  void showQuantityDialog(
    context,
    TextEditingController controller, {
    String? title,
    Function(BuildContext ctx, String)? onSuccess,
  }) {}

  void showStarDialog(
    context,
    String title, {
    int currentRating = 0,
    Function(BuildContext ctx, int)? onSuccess,
  }) {}

  Future<String> asyncInputDialog(
    BuildContext context,
    String title, {
    String? defaultText,
    List<Widget> Function(BuildContext)? buttonBuilder,
    TextInputType? inputType,
  }) async =>
      '';
}
