import './enumBase.dart';

enum AssistantAppType {
  Unknown,
  NMS,
  SMS,
  KGZ,
  DKM,
}

final assistantAppTypeValues = EnumValues({
  "Unknown": AssistantAppType.Unknown,
  "NMS": AssistantAppType.NMS,
  "SMS": AssistantAppType.SMS,
  "KGZ": AssistantAppType.KGZ,
  "DKM": AssistantAppType.DKM,
});
