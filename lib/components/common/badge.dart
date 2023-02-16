import 'package:flutter/material.dart' hide Badge;
import 'package:badges/badges.dart';

import '../../integration/dependency_injection.dart';

class BasicBadge extends StatelessWidget {
  final String text;
  final Widget? child;
  final Color? textColour;

  const BasicBadge({
    Key? key,
    required this.text,
    required this.child,
    required this.textColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: Text(
        text,
        style: (textColour != null) ? TextStyle(color: textColour) : null,
      ),
      badgeStyle: BadgeStyle(
        badgeColor: getTheme().getSecondaryColour(context),
        padding: const EdgeInsets.all(8),
      ),
      position: BadgePosition.bottomEnd(),
      child: child,
    );
  }
}
