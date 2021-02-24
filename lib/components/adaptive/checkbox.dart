import 'package:assistantapps_flutter_common/helpers/deviceHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget adaptiveCheckbox(
    {@required bool value,
    Color activeColor,
    @required void Function(bool newValue) onChanged}) {
  if (isiOS) return iosCheckbox(value, activeColor, onChanged);
  return androidCheckbox(value, activeColor, onChanged);
}

Widget androidCheckbox(
    bool value, Color activeColor, Function(bool newVallue) onChanged) {
  return Switch(
    value: value,
    activeColor: activeColor,
    onChanged: onChanged,
  );
}

Widget iosCheckbox(
    bool value, Color activeColor, Function(bool newVallue) onChanged) {
  return CupertinoSwitch(
    value: value,
    activeColor: activeColor,
    onChanged: onChanged,
  );
}
