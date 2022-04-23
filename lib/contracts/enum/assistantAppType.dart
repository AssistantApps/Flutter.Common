import 'enumBase.dart';

enum AssistantAppType {
  Unknown,
  NMS,
  SMS,
  KGZ,
}

final assistantAppTypeValues = EnumValues({
  "Unknown": AssistantAppType.Unknown,
  "NMS": AssistantAppType.NMS,
  "SMS": AssistantAppType.SMS,
  "KGZ": AssistantAppType.KGZ,
});
