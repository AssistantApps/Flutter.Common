import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

class PositiveButton extends StatelessWidget {
  final String title;
  final String? eventString;
  final EdgeInsets? padding;
  final Size? minimumSize;
  final Color? backgroundColour;
  final Color? foregroundColour;
  final void Function()? onTap;

  const PositiveButton({
    Key? key,
    required this.title,
    this.eventString,
    this.padding,
    this.minimumSize,
    this.backgroundColour,
    this.foregroundColour,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(title, textAlign: TextAlign.center);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColour ?? getTheme().buttonBackgroundColour(context),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          foregroundColour ?? getTheme().buttonForegroundColour(context),
        ),
        minimumSize: MaterialStateProperty.all<Size?>(minimumSize),
      ),
      onPressed: (onTap != null) ? onTap : null,
      child: padding != null
          ? Padding(padding: padding!, child: textWidget)
          : textWidget,
    );
  }
}

Widget positiveIconButton(
  Color colour, {
  required IconData icon,
  EdgeInsets? padding,
  Function()? onPress,
}) =>
    ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colour),
      ),
      onPressed: (onPress != null) ? onPress : null,
      child: padding == null
          ? Icon(icon)
          : Padding(
              padding: padding,
              child: Icon(icon),
            ),
    );

class NegativeButton extends StatelessWidget {
  final String title;
  final String? eventString;
  final EdgeInsets? padding;
  final Color backgroundColour;
  final void Function()? onTap;

  const NegativeButton({
    Key? key,
    required this.title,
    this.eventString,
    this.padding,
    this.backgroundColour = Colors.red,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(title, textAlign: TextAlign.center);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColour),
        foregroundColor: MaterialStateProperty.all<Color>(
          getTheme().getH1Colour(context),
        ),
      ),
      onPressed: (onTap != null) ? onTap : null,
      child: padding != null
          ? Padding(padding: padding!, child: textWidget)
          : textWidget,
    );
  }
}

Widget disabledButton({required String title}) => ElevatedButton(
      onPressed: null,
      child: Text(title),
    );
