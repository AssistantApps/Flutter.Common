import 'package:flutter/material.dart';

import 'stringHelper.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static String invertColorToHex(String hexColor) {
    if (hexColor.indexOf('#') == 0) {
      hexColor = hexColor.substring(1);
    }
    // convert 3-digit hex to 6-digits.
    if (hexColor.length == 3) {
      hexColor = hexColor[0] +
          hexColor[0] +
          hexColor[1] +
          hexColor[1] +
          hexColor[2] +
          hexColor[2];
    }
    if (hexColor.length != 6) {
      throw new Exception('Invalid HEX color.');
    }

    // invert color components
    String r = (255 - int.parse(hexColor.substring(0, 2), radix: 16))
        .toRadixString(16);
    String g = (255 - int.parse(hexColor.substring(2, 4), radix: 16))
        .toRadixString(16);
    String b = (255 - int.parse(hexColor.substring(4, 6), radix: 16))
        .toRadixString(16);
    // pad each with zeros and return
    return '#' + padString(r, 0) + padString(g, 2) + padString(b, 2);
  }

  static Color invertColor(String hexColor) =>
      HexColor(invertColorToHex(hexColor));
}

Color getOverlayColour(Color bgColour) {
  Color iconColour = bgColour.computeLuminance() > 0.5 //
      ? Colors.black87
      : Colors.white;
  return iconColour;
}
