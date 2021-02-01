import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/search/dropdownOption.dart';
import 'interface/IDialogService.dart';

class DialogService implements IDialogService {
  //
  void showSimpleDialog<T>(context, String title, Widget content,
      {List<T> buttons}) {}
  void showSimpleHelpDialog<T>(context, String title, String helpContent,
      {List<T> buttons}) {}
  Widget simpleDialogCloseButton(context, {Function onTap}) => Container();
  Widget simpleDialogPositiveButton(context,
          {LocaleKey title, Function onTap}) =>
      Container();
  void showOptionsDialog(context, String title, List<DropdownOption> options,
      {String selectedValue = '', Function(String value) onSuccess}) {}
  void showQuantityDialog(context, TextEditingController controller,
      {String title, Function(String) onSuccess}) {}
  void showStarDialog(context, String title,
      {int currentRating = 0, Function(int) onSuccess}) {}
}
