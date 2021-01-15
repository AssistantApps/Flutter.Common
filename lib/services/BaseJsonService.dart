import 'dart:convert';

import 'package:flutter/material.dart';

class BaseJsonService {
  void Function(String) debug;
  void Function(String) error;
  BaseJsonService(
      {void Function(String) debugLogger, void Function(String) errorLogger}) {
    debug = debugLogger ?? (String msg) => print(msg);
    error = errorLogger ?? (String msg) => print(msg);
  }

  Future<List> getListfromJson(context, jsonFileName) async {
    dynamic jsonString = await getJsonFromAssets(context, 'json/$jsonFileName');
    return json.decode(jsonString);
  }

  Future<dynamic> getJsonFromAssets(context, String jsonFileName) async {
    var jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/$jsonFileName.json');
    return jsonString;
  }
}
