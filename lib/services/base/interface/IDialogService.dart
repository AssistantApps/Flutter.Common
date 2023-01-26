import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/search/dropdownOption.dart';

class IDialogService {
  //
  void showSimpleDialog(
    BuildContext context,
    String title,
    Widget content, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  void showSimpleHelpDialog(
    BuildContext context,
    String title,
    String helpContent, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  Widget simpleDialogCloseButton(
    BuildContext context, {
    void Function()? onTap,
  }) =>
      Container();

  Widget simpleDialogPositiveButton(
    BuildContext context, {
    LocaleKey? title,
    void Function()? onTap,
  }) =>
      Container();

  void showOptionsDialog(
    BuildContext context,
    String title,
    List<DropdownOption> options, {
    String selectedValue = '',
    void Function(BuildContext ctx, String value)? onSuccess,
  }) {}

  void showQuantityDialog(
    BuildContext context,
    TextEditingController controller, {
    String? title,
    List<int>? amounts,
    void Function(BuildContext ctx, String)? onSuccess,
  }) {}

  void showStarDialog(
    BuildContext context,
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
