import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Option<AssistantAppType>> getAssistantAppTypeOptions() => [
      const Option<AssistantAppType>(
        label: 'Unknown',
        value: AssistantAppType.Unknown,
      ),
      const Option<AssistantAppType>(
        label: 'NMS',
        value: AssistantAppType.NMS,
      ),
      const Option<AssistantAppType>(
        label: 'SMS',
        value: AssistantAppType.SMS,
      ),
      const Option<AssistantAppType>(
        label: 'DKM',
        value: AssistantAppType.DKM,
      ),
      const Option<AssistantAppType>(
        label: 'KGZ',
        value: AssistantAppType.KGZ,
      ),
    ];
