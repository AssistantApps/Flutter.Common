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

Future<String> getDeviceId() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  if (deviceId == null || deviceId.length < 5) {
    deviceId = getNewGuid();
  }
  return deviceId.trim();
}

List<PlatformType> getPlatforms() {
  List<PlatformType> plats = List.empty(growable: true);
  if (isiOS || isApple) plats.add(PlatformType.Apple);
  if (isAndroid) plats.add(PlatformType.Android);
  if (isWindows) plats.add(PlatformType.Windows);
  if (isWeb) plats.add(PlatformType.Web);
  return plats;
}

List<Widget> actionItemToAndroidAction(List<ActionItem> actions) {
  List<Widget> result = List.empty(growable: true);
  for (ActionItem action in actions) {
    if (action.image != null) {
      result.add(InkWell(
        child: action.image,
        onTap: action.onPressed,
      ));
    } else {
      result.add(
        IconButton(
          icon: Icon(action.icon),
          tooltip: action.text,
          onPressed: action.onPressed,
        ),
      );
    }
  }
  return result;
}

List<Widget> actionItemToAppleAction(context, List<ActionItem> actions) {
  List<Widget> result = List.empty(growable: true);
  for (ActionItem action in actions) {
    if (action.image != null) {
      result.add(InkWell(child: action.image, onTap: action.onPressed));
    } else {
      result.add(
        InkWell(
          child: Icon(
            action.icon,
            color: getTheme().getPrimaryColour(context),
          ),
          onTap: action.onPressed,
        ),
      );
    }
  }
  return result;
}

Widget customDivider() => isWeb ? Divider(thickness: .5) : Divider();
