import 'package:assistantapps_flutter_common/contracts/enum/platformType.dart';
import 'package:universal_platform/universal_platform.dart';

bool isDebugingIos = false;

bool isApple =
    UniversalPlatform.isIOS || UniversalPlatform.isMacOS || isDebugingIos;

bool isiOS = UniversalPlatform.isIOS;
bool isAndroid = UniversalPlatform.isAndroid;
bool isWeb = UniversalPlatform.isWeb;

List<PlatformType> getPlatforms() {
  List<PlatformType> plats = List.empty(growable: true);
  if (isiOS || isApple) plats.add(PlatformType.Apple);
  if (isAndroid) plats.add(PlatformType.Android);
  if (isWeb) plats.add(PlatformType.Web);
  return plats;
}
