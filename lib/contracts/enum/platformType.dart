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
