import 'package:flutter/material.dart' hide Badge;
import 'package:badges/badges.dart';

import '../../integration/dependencyInjection.dart';

Widget basicBadge(BuildContext context, String badgeText, Widget child) {
  return Badge(
    badgeContent: Text(badgeText),
    badgeColor: getTheme().getSecondaryColour(context),
    position: BadgePosition.bottomEnd(),
    child: child,
    padding: EdgeInsets.all(8),
  );
}
