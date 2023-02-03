import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../integration/dependency_injection.dart';

class AdaptiveCheckboxGroup extends StatelessWidget {
  final List<String> allItemList;
  final List<String>? selectedItems;
  final List<String>? disabledItems;
  final Color? activeColor;
  final Color? unselectedColor;
  final void Function(List<String>)? onChanged;

  const AdaptiveCheckboxGroup({
    Key? key,
    required this.allItemList,
    this.selectedItems,
    this.disabledItems,
    this.activeColor,
    this.unselectedColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> localSelectedItems = selectedItems ?? [];
    List<String> localDisabledItems = disabledItems ?? [];
    Color localActiveColor =
        activeColor ?? getTheme().getSecondaryColour(context);
    Color localUnselectedColor =
        unselectedColor ?? getTheme().getCardBackgroundColour(context);
    void Function(List<String>) localOnChanged = onChanged ?? (_) {};

    List<int> selectedItemIndexes = allItemList
        .where((String all) => localSelectedItems.contains(all))
        .map((String sel) => allItemList.indexOf(sel))
        .where((all) => all >= 0)
        .toList();

    List<int> disabledItemIndexes = allItemList
        .where((String all) => localDisabledItems.contains(all))
        .map((String dis) => allItemList.indexOf(dis))
        .where((all) => all >= 0)
        .toList();

    return GroupButton(
      controller: GroupButtonController(
        selectedIndexes: selectedItemIndexes,
        disabledIndexes: disabledItemIndexes,
      ),
      isRadio: false,
      buttons: allItemList,
      options: GroupButtonOptions(
        groupingType: GroupingType.wrap,
        direction: Axis.horizontal,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        selectedColor: localActiveColor,
        selectedTextStyle: const TextStyle(color: Colors.black),
        unselectedColor: localUnselectedColor,
      ),
      onSelected: (String value, int index, bool isSelected) {
        String selectedItem = allItemList[index];
        if (isSelected) {
          localOnChanged([...localSelectedItems, selectedItem]);
        } else {
          localOnChanged(
            localSelectedItems
                .where((element) => element != selectedItem)
                .toList(),
          );
        }
      },
    );
  }
}
