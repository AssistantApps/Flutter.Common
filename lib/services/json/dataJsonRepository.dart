import 'dart:convert';

import 'package:flutter/material.dart';

import '../../contracts/data/assistantAppLinks.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseJsonService.dart';
import 'interface/IdataJsonRepository.dart';

class DataJsonRepository extends BaseJsonService
    implements IDataJsonRepository {
  //

  @override
  Future<ResultWithValue<List<AssistantAppLinks>>> getAssistantApps(
      BuildContext context,
      {String path = 'data/assistantAppLinks'}) async {
    try {
      dynamic responseJson = await this.getJsonFromAssets(context, path);
      List list = json.decode(responseJson);
      List<AssistantAppLinks> assistAppItems =
          list.map((m) => AssistantAppLinks.fromJson(m)).toList();
      return ResultWithValue<List<AssistantAppLinks>>(true, assistAppItems, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getAssistantApps Exception: ${exception.toString()}");
      return ResultWithValue<List<AssistantAppLinks>>(
          false, List<AssistantAppLinks>(), exception.toString());
    }
  }
}
