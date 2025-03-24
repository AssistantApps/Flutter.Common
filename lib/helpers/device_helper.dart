import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:universal_platform/universal_platform.dart';

import '../contracts/enum/platform_type.dart';
import '../contracts/misc/action_item.dart';
import '../integration/dependency_injection.dart';
import './guid_helper.dart';

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
  String deviceId = await FlutterUdid.udid;
  if (deviceId.length < 5) {
    deviceId = getNewGuid();
  }
  return deviceId.trim();
}

List<PlatformType> getPlatforms() {
  if (getEnv().isGithubRelease) {
    return [PlatformType.githubWindowsInstaller];
  }
  List<PlatformType> plats = List.empty(growable: true);
  if (isiOS || isApple) plats.add(PlatformType.iOS);
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
          icon: Icon(action.icon),
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
