import 'package:flutter/material.dart';

Widget wrapInNewBanner(BuildContext context, String message, Widget child) =>
    ClipRect(
      child: Banner(
        message: message,
        location: BannerLocation.topEnd,
        child: child,
      ),
    );
