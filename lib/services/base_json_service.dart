import 'dart:convert';

import 'package:assistantapps_flutter_common/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class BaseJsonService {
  Future<List> getListfromJson(context, jsonFileName) async {
    dynamic jsonString = await getJsonFromAssets(context, 'json/$jsonFileName');
    return json.decode(jsonString);
  }

  // AssistantNMS specific, remove once new Guide system works
  Future<dynamic> getJsonGuide(
      context, String guideFolder, String jsonFileName) async {
    dynamic jsonString =
        await getJsonFromAssets(context, 'guide/$guideFolder/$jsonFileName');
    return json.decode(jsonString);
  }

  Future<dynamic> getJsonFromAssets(context, String jsonFileName) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/$jsonFileName.json');
    return jsonString;
  }

  Future<dynamic> getJsonFromCommonPackage(context, String jsonFileName) async {
    String jsonString = await DefaultAssetBundle.of(context).loadString(
        'packages/${UIConstants.commonPackage}/assets/$jsonFileName.json');
    return jsonString;
  }
}
