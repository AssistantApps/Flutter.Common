import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Option<AssistantAppType>> getAssistantAppTypeOptions() => [
      const Option<AssistantAppType>(
        label: 'Unknown',
        value: AssistantAppType.unknown,
      ),
      const Option<AssistantAppType>(
        label: 'NMS',
        value: AssistantAppType.nms,
      ),
      const Option<AssistantAppType>(
        label: 'SMS',
        value: AssistantAppType.sms,
      ),
      const Option<AssistantAppType>(
        label: 'DKM',
        value: AssistantAppType.dkm,
      ),
      const Option<AssistantAppType>(
        label: 'KGZ',
        value: AssistantAppType.kgz,
      ),
    ];
