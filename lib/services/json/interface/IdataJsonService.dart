import 'package:flutter/material.dart';

import '../../../contracts/generated/apps_link_view_model.dart';
import '../../../contracts/results/result_with_value.dart';

class IDataJsonService {
  Future<ResultWithValue<List<AssistantAppsLinkViewModel>>> getAssistantApps(
      BuildContext context) async {
    return ResultWithValue<List<AssistantAppsLinkViewModel>>(
        false, List.empty(growable: true), '');
  }
}
