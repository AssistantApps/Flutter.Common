import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';

Widget wrapInNewBanner(BuildContext context, LocaleKey message, Widget child) =>
    ClipRect(
      child: Banner(
        message: Translations.fromKey(message),
        location: BannerLocation.topEnd,
        child: child,
      ),
    );
