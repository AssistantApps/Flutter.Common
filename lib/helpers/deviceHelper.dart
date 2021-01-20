import 'dart:io';

import 'package:universal_platform/universal_platform.dart';

bool isDebugingIos = false;

bool isApple = Platform.isIOS || Platform.isMacOS || isDebugingIos;

bool isiOS = Platform.isIOS;
bool isAndroid = Platform.isAndroid;
bool isWeb = UniversalPlatform.isWeb;
