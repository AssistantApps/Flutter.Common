import 'package:flutter/material.dart';

import '../../integration/dependencyInjection.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final String? eventString;
  final EdgeInsets? padding;
  final Size? minimumSize;
  final Color backgroundColour;
  final Color foregroundColour;
  final void Function()? onTap;

  const BaseButton({
    Key? key,
    required this.title,
    this.eventString,
    this.padding,
    this.minimumSize,
    required this.backgroundColour,
    required this.foregroundColour,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text textWidget = Text(title, textAlign: TextAlign.center);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColour),
        foregroundColor: MaterialStateProperty.all<Color>(
          foregroundColour,
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
    return BaseButton(
      title: title,
      eventString: eventString,
      padding: padding,
      minimumSize: minimumSize,
      backgroundColour:
          backgroundColour ?? getTheme().buttonBackgroundColour(context),
      foregroundColour:
          foregroundColour ?? getTheme().buttonForegroundColour(context),
      onTap: onTap,
    );
  }
}

class PositiveIconButton extends StatelessWidget {
  final Color colour;
  final IconData icon;
  final EdgeInsets? padding;
  final void Function()? onPress;

  const PositiveIconButton({
    Key? key,
    required this.icon,
    required this.colour,
    this.padding,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colour),
      ),
      onPressed: onPress,
      child: padding != null
          ? Padding(padding: padding!, child: Icon(icon))
          : Icon(icon),
    );
  }
}

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
    return BaseButton(
      title: title,
      eventString: eventString,
      padding: padding,
      backgroundColour: backgroundColour,
      foregroundColour: getTheme().getH1Colour(context),
      onTap: onTap,
    );
  }
}


Widget disabledButton({required String title}) => ElevatedButton(
      onPressed: null,
      child: Text(title),
    );
