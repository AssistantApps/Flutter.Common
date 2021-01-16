import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
