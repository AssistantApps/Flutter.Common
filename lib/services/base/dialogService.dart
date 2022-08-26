import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/search/dropdownOption.dart';
import './interface/IDialogService.dart';

class DialogService implements IDialogService {
  //
  @override
  void showSimpleDialog(
    context,
    String title,
    Widget content, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  @override
  void showSimpleHelpDialog(
    context,
    String title,
    String helpContent, {
    List<Widget> Function(BuildContext)? buttonBuilder,
  }) {}

  @override
  Widget simpleDialogCloseButton(
    context, {
    Function()? onTap,
  }) =>
      Container();

  @override
  Widget simpleDialogPositiveButton(
    context, {
    LocaleKey? title,
    Function? onTap,
  }) =>
      Container();

  @override
  void showOptionsDialog(
    context,
    String title,
    List<DropdownOption> options, {
    String selectedValue = '',
    Function(BuildContext ctx, String value)? onSuccess,
  }) {}

  @override
  void showQuantityDialog(
    context,
    TextEditingController controller, {
    String? title,
    Function(BuildContext ctx, String)? onSuccess,
  }) {}

  @override
  void showStarDialog(
    context,
    String title, {
    int currentRating = 0,
    Function(BuildContext ctx, int)? onSuccess,
  }) {}

  @override
  Future<String> asyncInputDialog(
    BuildContext context,
    String title, {
    String? defaultText,
    List<Widget> Function(BuildContext)? buttonBuilder,
    TextInputType? inputType,
  }) async =>
      '';
}
