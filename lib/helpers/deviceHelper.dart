import 'dart:io';

bool isDebugingIos = false;

bool isApple = Platform.isIOS || Platform.isMacOS || isDebugingIos;

bool isiOS = Platform.isIOS;
bool isAndroid = Platform.isAndroid;
