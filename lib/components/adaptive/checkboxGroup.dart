import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../integration/dependencyInjection.dart';

Widget adaptiveCheckboxGroup(
  BuildContext context, {
  required List<String> allItemList,
  List<String>? selectedItems,
  List<String>? disabledItems,
  Color? activeColor,
  Color? unselectedColor,
  void Function(List<String>)? onChanged,
}) {
  // if (isiOS) return iosCheckboxGroup(value, activeColor, onChanged);
  return androidCheckboxGroup(
    context,
    allItemList,
    selectedItems ?? [],
    disabledItems ?? [],
    activeColor ?? getTheme().getSecondaryColour(context),
    unselectedColor ?? getTheme().getCardBackgroundColour(context),
    onChanged ?? (_) {},
  );
}

Widget androidCheckboxGroup(
  BuildContext context,
  List<String> allItemList,
  List<String> selectedItems,
  List<String> disabledItems,
  Color activeColor,
  Color unselectedColor,
  void Function(List<String>) onChanged,
) {
  List<int> selectedItemIndexes = allItemList
      .where((String all) => selectedItems.contains(all))
      .map((String sel) => allItemList.indexOf(sel))
      .where((all) => all >= 0)
      .toList();

  List<int> disabledItemIndexes = allItemList
      .where((String all) => disabledItems.contains(all))
      .map((String dis) => allItemList.indexOf(dis))
      .where((all) => all >= 0)
      .toList();
  return GroupButton(
    controller: GroupButtonController(
      selectedIndexes: selectedItemIndexes,
      disabledIndexes: disabledItemIndexes,
    ),
    isRadio: false,
    options: GroupButtonOptions(
      groupingType: GroupingType.wrap,
      direction: Axis.horizontal,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      selectedColor: activeColor,
      selectedTextStyle: TextStyle(color: Colors.black),
      unselectedColor: unselectedColor,
    ),
    onSelected: (index, isSelected) {
      String selectedItem = allItemList[index];
      if (isSelected) {
        onChanged([...selectedItems, selectedItem]);
      } else {
        onChanged(
          selectedItems.where((element) => element != selectedItem).toList(),
        );
      }
    },
    buttons: allItemList,
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
