import 'dart:convert';

import 'package:flutter/material.dart';

import '../../contracts/data/assistantAppLinks.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../integration/dependencyInjection.dart';
import '../BaseJsonService.dart';
import 'interface/IdataJsonService.dart';

class DataJsonService extends BaseJsonService implements IDataJsonService {
  //

  @override
  Future<ResultWithValue<List<AssistantAppLinks>>> getAssistantApps(
      BuildContext context) async {
    try {
      dynamic responseJson = await this.getJsonFromCommonPackage(
        context,
        'data/assistantAppLinks',
      );
      List list = json.decode(responseJson);
      List<AssistantAppLinks> assistAppItems =
          list.map((m) => AssistantAppLinks.fromJson(m)).toList();
      return ResultWithValue<List<AssistantAppLinks>>(true, assistAppItems, '');
    } catch (exception) {
      getLog().e(
          "DataJsonRepository getAssistantApps Exception: ${exception.toString()}");
      return ResultWithValue<List<AssistantAppLinks>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
