import 'dart:convert';

import 'package:flutter/material.dart';

import '../../contracts/generated/apps_link_view_model.dart';
import '../../contracts/results/result_with_value.dart';
import '../../integration/dependency_injection.dart';
import '../base_json_service.dart';
import './interface/idata_json_service.dart';

class DataJsonService extends BaseJsonService implements IDataJsonService {
  //

  @override
  Future<ResultWithValue<List<AssistantAppsLinkViewModel>>> getAssistantApps(
      BuildContext context) async {
    try {
      dynamic responseJson = await getJsonFromCommonPackage(
        context,
        'data/assistantAppLinks',
      );
      List list = json.decode(responseJson);
      List<AssistantAppsLinkViewModel> assistAppItems =
          list.map((m) => AssistantAppsLinkViewModel.fromJson(m)).toList();
      return ResultWithValue<List<AssistantAppsLinkViewModel>>(
          true, assistAppItems, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getAssistantApps Exception: ${exception.toString()}");
      return ResultWithValue<List<AssistantAppsLinkViewModel>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
