import './enum_base.dart';

enum AssistantAppType {
  unknown,
  nms,
  sms,
  kgz,
  dkm,
}

final assistantAppTypeValues = EnumValues({
  "Unknown": AssistantAppType.unknown,
  "NMS": AssistantAppType.nms,
  "SMS": AssistantAppType.sms,
  "KGZ": AssistantAppType.kgz,
  "DKM": AssistantAppType.dkm,
});
