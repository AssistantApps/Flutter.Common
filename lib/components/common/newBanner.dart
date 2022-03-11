import 'package:flutter/material.dart';

import '../../contracts/enum/localeKey.dart';
import '../../integration/dependencyInjection.dart';

Widget wrapInNewBanner(BuildContext context, LocaleKey message, Widget child,
        {BannerLocation location = BannerLocation.topEnd}) =>
    ClipRect(
      child: Banner(
        message: getTranslations().fromKey(message),
        location: location,
        child: child,
      ),
    );
