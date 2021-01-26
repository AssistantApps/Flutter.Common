import 'dart:convert';

import 'package:assistantapps_flutter_common/constants/UIConstants.dart';
import 'package:flutter/material.dart';

class BaseJsonService {
  Future<List> getListfromJson(context, jsonFileName) async {
    dynamic jsonString = await getJsonFromAssets(context, 'json/$jsonFileName');
    return json.decode(jsonString);
  }

  Future<dynamic> getJsonFromAssets(context, String jsonFileName) async {
    var jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/$jsonFileName.json');
    return jsonString;
  }

  Future<dynamic> getJsonFromCommonPackage(context, String jsonFileName) async {
    var jsonString = await DefaultAssetBundle.of(context).loadString(
        'packages/${UIConstants.CommonPackage}/assets/$jsonFileName.json');
    return jsonString;
  }
}
