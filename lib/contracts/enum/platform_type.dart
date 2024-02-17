import '../enum/enum_base.dart';

enum PlatformType {
  android,
  iOS,
  web,
  api,
  windows,
  githubWindowsInstaller,
  fdroid,
}

final platformTypeValues = EnumValues({
  "0": PlatformType.android,
  "1": PlatformType.iOS,
  "2": PlatformType.web,
  "3": PlatformType.api,
  "4": PlatformType.windows,
  "5": PlatformType.githubWindowsInstaller,
  "6": PlatformType.fdroid,
});

final platformTypeToIntValues = EnumValues({
  PlatformType.android.toString(): "0",
  PlatformType.iOS.toString(): "1",
  PlatformType.web.toString(): "2",
  PlatformType.api.toString(): "3",
  PlatformType.windows.toString(): "4",
  PlatformType.githubWindowsInstaller.toString(): "5",
  PlatformType.fdroid.toString(): "5",
});
