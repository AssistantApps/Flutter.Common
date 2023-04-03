import 'patreon_auth_button.dart';
import 'package:flutter/material.dart';

class AuthButton {
  // static Widget google({required void Function() onPressed}) =>
  //     GoogleAuthButton(
  //       onPressed: onPressed,
  //       themeMode: ThemeMode.dark,
  //     );

  static Widget patreon({required void Function() onPressed}) =>
      PatreonAuthButton(onPressed: onPressed);
}
