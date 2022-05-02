import 'package:package_info_plus/package_info_plus.dart';

import '../../contracts/results/resultWithValue.dart';

class VersionService {
  Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
    PackageInfo defaultResult =
        PackageInfo(appName: '', buildNumber: '', packageName: '', version: '');

    try {
      PackageInfo packInfo = await PackageInfo.fromPlatform();
      return ResultWithValue<PackageInfo>(true, packInfo, '');
    } catch (exception) {
      return ResultWithValue<PackageInfo>(
          false, defaultResult, exception.toString());
    }
  }
}
