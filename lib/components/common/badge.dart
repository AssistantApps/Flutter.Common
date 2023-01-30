import 'package:flutter/material.dart' hide Badge;
import 'package:badges/badges.dart';

import '../../integration/dependencyInjection.dart';

Widget basicBadge(BuildContext context, String badgeText, Widget? child) {
  return Badge(
    badgeContent: Text(badgeText),
    badgeStyle: BadgeStyle(
      badgeColor: getTheme().getSecondaryColour(context),
      padding: const EdgeInsets.all(8),
    ),
    position: BadgePosition.bottomEnd(),
    child: child,
  );
}
