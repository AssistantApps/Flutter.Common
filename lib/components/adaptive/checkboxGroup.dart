import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';

import '../../integration/dependencyInjection.dart';

Widget adaptiveCheckboxGroup(
  BuildContext context, {
  @required List<String> allItemList,
  List<String> selectedItems,
  Color checkColor,
  Color activeColor,
  void Function(List<String>) onChanged,
}) {
  // if (isiOS) return iosCheckboxGroup(value, activeColor, onChanged);
  return androidCheckboxGroup(
    context,
    allItemList ?? [],
    selectedItems ?? [],
    checkColor ?? Colors.white,
    activeColor ?? getTheme().getSecondaryColour(context),
    onChanged ?? (_) {},
  );
}

Widget androidCheckboxGroup(
  BuildContext context,
  List<String> allItemList,
  List<String> selectedItems,
  Color checkColor,
  Color activeColor,
  void Function(List<String>) onChanged,
) {
  return GroupedCheckbox(
    itemList: allItemList,
    checkedItemList: selectedItems,
    onChanged: onChanged,
    orientation: CheckboxOrientation.HORIZONTAL,
    checkColor: checkColor,
    activeColor: activeColor,
  );
}

// Widget iosCheckboxGroup(
//   BuildContext context,
//   List<String> allItemList,
//   List<String> selectedItems,
//   Color checkColor,
//   Color activeColor,
//   void Function(List<String>) onChanged,
// ) {
//   return CupertinoSwitch(
//     value: value,
//     activeColor: activeColor,
//     onChanged: onChanged,
//   );
// }
