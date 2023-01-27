import 'package:flutter/material.dart';

class AdaptiveChip extends StatelessWidget {
  final String? text;
  final Widget? label;
  final TextStyle? style;
  final EdgeInsets? labelPadding;
  final double? elevation;
  final EdgeInsets? padding;
  final Color? shadowColor;
  final Icon? deleteIcon;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final Color backgroundColor;

  const AdaptiveChip({
    Key? key,
    this.text,
    this.label,
    this.style,
    this.labelPadding,
    this.elevation,
    this.padding,
    this.shadowColor,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.backgroundColor = Colors.white,
  })  : assert(text != null || label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var actualChip = Chip(
      key: key,
      label: label ??
          Text(
            text ?? '',
            style: style,
          ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      padding: padding ?? const EdgeInsets.all(4.0),
      side: BorderSide(color: backgroundColor),
      backgroundColor: backgroundColor,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      labelPadding: labelPadding,
      elevation: elevation,
      shadowColor: shadowColor,
    );

    return (onTap == null)
        ? actualChip
        : GestureDetector(child: actualChip, onTap: onTap);
  }
}
