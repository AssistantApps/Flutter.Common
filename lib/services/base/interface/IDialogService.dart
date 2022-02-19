import 'package:flutter/material.dart';

import '../../../contracts/enum/localeKey.dart';
import '../../../contracts/search/dropdownOption.dart';

class IDialogService {
  //
  void showSimpleDialog(context, String title, Widget content,
      {List<Widget>? buttons}) {}
  void showSimpleHelpDialog(context, String title, String helpContent,
      {List<Widget>? buttons}) {}
  Widget simpleDialogCloseButton(context, {Function()? onTap}) => Container();
  Widget simpleDialogPositiveButton(context,
          {LocaleKey? title, Function? onTap}) =>
      Container();
  void showOptionsDialog(context, String title, List<DropdownOption> options,
      {String selectedValue = '', Function(String value)? onSuccess}) {}
  void showQuantityDialog(context, TextEditingController controller,
      {String? title, Function(String)? onSuccess}) {}
  void showStarDialog(context, String title,
      {int currentRating = 0, Function(int)? onSuccess}) {}
  Future<String> asyncInputDialog(BuildContext context, String title,
          {String? defaultText,
          List<Widget>? actions,
          TextInputType? inputType}) async =>
      '';
}
