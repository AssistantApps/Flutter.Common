import 'enumBase.dart';

enum AssistantAppType {
  Unknown,
  NMS,
  SMS,
}

final assistantAppTypeValues = EnumValues({
  "0": AssistantAppType.Unknown,
  "1": AssistantAppType.NMS,
  "2": AssistantAppType.SMS,
});
