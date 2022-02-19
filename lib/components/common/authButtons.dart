import 'patreonAuthButton.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;

class AuthButton {
  static Widget google({required void Function() onPressed}) =>
      GoogleAuthButton(
        onPressed: onPressed,
        darkMode: true,
      );

  static Widget patreon({required void Function() onPressed}) =>
      PatreonAuthButton(onPressed: onPressed);
}
