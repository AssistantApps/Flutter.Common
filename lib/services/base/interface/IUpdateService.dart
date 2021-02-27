import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../contracts/results/resultWithValue.dart';

class IUpdateService {
  Future<void> checkForUpdate(BuildContext context, String externalUrl) async {}

  Future<ResultWithValue<bool>> isOutdatedVersionCheck() async {
    return ResultWithValue<bool>(false, false, 'Not Implemented');
  }
}
