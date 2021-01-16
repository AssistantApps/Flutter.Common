import 'package:flutter/material.dart';

import '../../../contracts/data/assistantAppLinks.dart';
import '../../../contracts/results/resultWithValue.dart';

class IDataJsonService {
  Future<ResultWithValue<List<AssistantAppLinks>>> getAssistantApps(
      BuildContext context,
      {String path = 'data/assistantAppLinks'}) async {
    return ResultWithValue<List<AssistantAppLinks>>(
        false, List<AssistantAppLinks>(), '');
  }
}
