import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../integration/dependencyInjection.dart';
import '../common/image.dart';

const defaultPadding = EdgeInsets.only(top: 12, bottom: 6);

Widget adaptiveSegmentedControl(
  BuildContext context, {
  required List<Widget> controlItems,
  required int currentSelection,
  required void Function(int) onSegmentChosen,
  double verticalOffset = 12.0,
  double? borderRadius,
  EdgeInsets? padding,
}) =>
    androidSegmentedControl(
      context,
      controlItems,
      currentSelection,
      onSegmentChosen,
      verticalOffset,
      borderRadius: borderRadius,
      padding: padding,
    ); //TODO fix iOS crap
// isiOS
//     ? androidSegmentedControl(
//         context, controlItems, currentSelection, onSegmentChosen)
//     : androidSegmentedControl(
//         context, controlItems, currentSelection, onSegmentChosen);

Widget androidSegmentedControl(
  BuildContext context,
  List<Widget> controlItems,
  int currentSelection,
  void Function(int) onSegmentChosen,
  double verticalOffset, {
  double? borderRadius,
  EdgeInsets? padding,
}) {
  Map<int, Widget> map = <int, Widget>{};
  for (int childIndex = 0; childIndex < controlItems.length; childIndex++) {
    map.putIfAbsent(childIndex, () => controlItems[childIndex]);
  }

  return MaterialSegmentedControl(
    children: map,
    selectionIndex: currentSelection,
    borderColor: getTheme().getSecondaryColour(context),
    selectedColor: getTheme().getSecondaryColour(context),
    unselectedColor: getTheme().getIsDark(context)
        ? const Color.fromRGBO(47, 47, 47, 1)
        : Colors.white,
    borderRadius: borderRadius ?? 4.0,
    verticalOffset: verticalOffset,
    horizontalPadding: padding ?? defaultPadding,
    onSegmentChosen: onSegmentChosen,
  );
}

// Widget _iosSegmentedControl(BuildContext context, List<Widget> controlItems,
//     int currentSelection, void Function(int) onSegmentChosen) {}

Widget getSegmentedControlOption(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Text(text),
  );
}

Widget getImageSegmentedControlOption(String path) {
  return localImage(path, width: 30, height: 30);
}

Widget getSegmentedControlWithIconOption(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(icon),
        ),
        Text(text)
      ],
    ),
  );
}
