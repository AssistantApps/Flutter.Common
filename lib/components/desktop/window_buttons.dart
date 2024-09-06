import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../helpers/colour_helper.dart';
import '../../integration/dependency_injection_base.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    Color hoverColour = getTheme().getSecondaryColour(context);
    Color textColour = getTheme().getTextColour(context);
    Color textHoverColour = getTheme().getForegroundTextColour(hoverColour);

    WindowButtonColors buttonColors = WindowButtonColors(
      mouseOver: hoverColour,
      mouseDown: hoverColour,
      iconNormal: textColour,
      iconMouseOver: textHoverColour,
    );

    WindowButtonColors closeButtonColors = WindowButtonColors(
      mouseOver: HexColor('E81123'),
      mouseDown: HexColor('E81123'),
      iconNormal: textColour,
      iconMouseOver: textHoverColour,
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
