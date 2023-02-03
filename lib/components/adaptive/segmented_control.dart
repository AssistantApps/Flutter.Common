import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../integration/dependency_injection.dart';
import '../common/image.dart';

const defaultPadding = EdgeInsets.only(top: 12, bottom: 6);

class AdaptiveSegmentedControl extends StatelessWidget {
  final List<Widget> controlItems;
  final int currentSelection;
  final void Function(int) onSegmentChosen;
  final double verticalOffset;
  final double? borderRadius;
  final EdgeInsets? padding;

  const AdaptiveSegmentedControl({
    Key? key,
    required this.controlItems,
    required this.currentSelection,
    required this.onSegmentChosen,
    this.verticalOffset = 12.0,
    this.borderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class SegmentedControlOption extends StatelessWidget {
  final String text;

  const SegmentedControlOption(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(text),
    );
  }
}

class ImageSegmentedControlOption extends StatelessWidget {
  final String path;

  const ImageSegmentedControlOption(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocalImage(imagePath: path, width: 30, height: 30);
  }
}

class SegmentedControlWithIconOption extends StatelessWidget {
  final IconData icon;
  final String text;

  const SegmentedControlWithIconOption({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
