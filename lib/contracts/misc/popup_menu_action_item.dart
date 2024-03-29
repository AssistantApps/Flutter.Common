import 'package:flutter/material.dart';

class PopupMenuActionItem {
  final IconData icon;
  Widget? image;
  final String text;
  final TextStyle? style;
  final Function() onPressed;
  final int? sortOrder;

  PopupMenuActionItem({
    required this.icon,
    required this.onPressed,
    required this.text,
    this.image,
    this.style,
    this.sortOrder,
  });
}
