import 'package:flutter/material.dart';

import '../../contracts/enum/locale_key.dart';
import '../../integration/dependency_injection.dart';

class WrapInNewBanner extends StatelessWidget {
  final LocaleKey message;
  final Widget child;
  final BannerLocation location;

  const WrapInNewBanner({
    super.key,
    required this.message,
    required this.child,
    this.location = BannerLocation.topEnd,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Banner(
        message: getTranslations().fromKey(message),
        location: location,
        child: child,
      ),
    );
  }
}
