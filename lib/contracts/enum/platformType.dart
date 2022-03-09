import '../enum/enumBase.dart';

enum PlatformType {
  Android,
  Apple,
  Web,
  API,
}

final platformTypeValues = EnumValues({
  "0": PlatformType.Android,
  "1": PlatformType.Apple,
  "2": PlatformType.Web,
  "3": PlatformType.API,
});

final platformTypeToIntValues = EnumValues({
  PlatformType.Android.toString(): "0",
  PlatformType.Apple.toString(): "1",
  PlatformType.Web.toString(): "2",
  PlatformType.API.toString(): "3",
});
