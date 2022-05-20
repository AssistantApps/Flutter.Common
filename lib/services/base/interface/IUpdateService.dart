import 'dart:async';

import 'package:flutter/material.dart';

import '../../../contracts/misc/versionDetail.dart';
import '../../../contracts/results/resultWithValue.dart';

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
