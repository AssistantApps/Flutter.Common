import '../enum/enum_base.dart';

enum PlatformType {
  android,
  apple,
  web,
  api,
  windows,
  githubWindowsInstaller,
}

final platformTypeValues = EnumValues({
  "0": PlatformType.android,
  "1": PlatformType.apple,
  "2": PlatformType.web,
  "3": PlatformType.api,
  "4": PlatformType.windows,
  "5": PlatformType.githubWindowsInstaller,
});

final platformTypeToIntValues = EnumValues({
  PlatformType.android.toString(): "0",
  PlatformType.apple.toString(): "1",
  PlatformType.web.toString(): "2",
  PlatformType.api.toString(): "3",
  PlatformType.windows.toString(): "4",
  PlatformType.githubWindowsInstaller.toString(): "5",
});
