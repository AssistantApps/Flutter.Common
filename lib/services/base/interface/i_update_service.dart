import 'dart:async';

import 'package:flutter/material.dart';

import '../../../contracts/misc/version_detail.dart';
import '../../../contracts/results/result_with_value.dart';

class IUpdateService {
  Future<void> checkForUpdate(BuildContext context, String externalUrl) async {}

  Future<ResultWithValue<bool>> isOutdatedVersionCheck() async {
    return ResultWithValue<bool>(false, false, 'Not Implemented');
  }

  Future<ResultWithValue<VersionDetail>> getPackageInfo() async {
    return ResultWithValue<VersionDetail>(
      false,
      VersionDetail(
        buildNumber: '',
        packageName: '',
        version: '',
      ),
      '',
    );
  }
}
