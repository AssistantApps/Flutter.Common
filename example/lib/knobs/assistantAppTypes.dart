import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Option<AssistantAppType>> getAssistantAppTypeOptions() => [
      Option<AssistantAppType>(
        label: 'Unknown',
        value: AssistantAppType.Unknown,
      ),
      Option<AssistantAppType>(
        label: 'NMS',
        value: AssistantAppType.NMS,
      ),
      Option<AssistantAppType>(
        label: 'SMS',
        value: AssistantAppType.SMS,
      ),
      Option<AssistantAppType>(
        label: 'KGZ',
        value: AssistantAppType.KGZ,
      ),
    ];
