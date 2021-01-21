import 'package:universal_platform/universal_platform.dart';

bool isDebugingIos = false;

bool isApple =
    UniversalPlatform.isIOS || UniversalPlatform.isMacOS || isDebugingIos;

bool isiOS = UniversalPlatform.isIOS;
bool isAndroid = UniversalPlatform.isAndroid;
bool isWeb = UniversalPlatform.isWeb;
