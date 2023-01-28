import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:universal_platform/universal_platform.dart';

import '../contracts/enum/platformType.dart';
import '../contracts/misc/actionItem.dart';
import '../integration/dependencyInjection.dart';
import './guidHelper.dart';

bool isDebugingIos = false;

bool isApple = UniversalPlatform.isIOS ||
    UniversalPlatform.isMacOS || //
    isDebugingIos;

bool isiOS = UniversalPlatform.isIOS;
bool isAndroid = UniversalPlatform.isAndroid;
bool isWeb = UniversalPlatform.isWeb;
bool isDesktop = UniversalPlatform.isDesktop;
bool isWindows = UniversalPlatform.isWindows;
bool isLinux = UniversalPlatform.isLinux;

Future<String> getDeviceId() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  if (deviceId == null || deviceId.length < 5) {
    deviceId = getNewGuid();
  }
  return deviceId.trim();
}

List<PlatformType> getPlatforms() {
  List<PlatformType> plats = List.empty(growable: true);
  if (isiOS || isApple) plats.add(PlatformType.apple);
  if (isAndroid) plats.add(PlatformType.android);
  if (isWindows) plats.add(PlatformType.windows);
  if (isWeb) plats.add(PlatformType.web);
  return plats;
}

List<Widget> actionItemToAndroidAction(
  BuildContext context,
  List<ActionItem> actions,
) {
  List<Widget> result = List.empty(growable: true);
  for (ActionItem action in actions) {
    if (action.image != null) {
      result.add(
        InkWell(
          onTap: action.onPressed,
          child: action.image,
        ),
      );
    } else {
      result.add(
        IconButton(
          icon: Icon(
            action.icon,
            color: getTheme().getTextColour(context),
          ),
          tooltip: action.text,
          onPressed: action.onPressed,
        ),
      );
    }
  }
  return result;
}

List<Widget> actionItemToAppleAction(
  BuildContext context,
  List<ActionItem> actions,
) {
  List<Widget> result = List.empty(growable: true);
  for (ActionItem action in actions) {
    if (action.image != null) {
      result.add(
        InkWell(
          onTap: action.onPressed,
          child: action.image,
        ),
      );
    } else {
      result.add(
        InkWell(
          onTap: action.onPressed,
          child: Icon(
            action.icon,
            color: getTheme().getPrimaryColour(context),
          ),
        ),
      );
    }
  }
  return result;
}

Widget customDivider() =>
    isWeb ? const Divider(thickness: .5) : const Divider();
