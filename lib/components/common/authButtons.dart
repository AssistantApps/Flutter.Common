import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;

class AuthButton {
  static Widget google(
          {@required void Function() onPressed, bool darkMode = true}) =>
      GoogleAuthButton(
        onPressed: onPressed,
        darkMode: darkMode,
      );
}
