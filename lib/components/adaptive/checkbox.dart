import 'package:assistantapps_flutter_common/helpers/deviceHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../integration/dependencyInjectionBase.dart';

class AdaptiveCheckbox extends StatelessWidget {
  final bool value;
  final Color? activeColor;
  final void Function(bool newValue) onChanged;

  const AdaptiveCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      return CupertinoSwitch(
        value: value,
        activeColor: activeColor ?? getTheme().getSecondaryColour(context),
        onChanged: onChanged,
      );
    }

    return Switch(
      value: value,
      activeColor: activeColor ?? getTheme().getSecondaryColour(context),
      onChanged: onChanged,
    );
  }
}
