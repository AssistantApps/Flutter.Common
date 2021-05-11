import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import '../../assistantapps_flutter_common.dart';

Widget basicBadge(BuildContext context, String badgeText, Widget child) {
  return Badge(
    badgeContent: Text(badgeText),
    badgeColor: getTheme().getSecondaryColour(context),
    position: BadgePosition.bottomEnd(),
    child: child,
    padding: EdgeInsets.all(8),
  );
}
