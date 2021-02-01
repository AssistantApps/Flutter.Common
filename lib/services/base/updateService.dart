import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../contracts/enum/localeKey.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/versionViewModel.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../integration/dependencyInjection.dart';
import 'interface/IUpdateService.dart';

class UpdateService implements IUpdateService {
  Future<void> checkForUpdate(BuildContext context, String externalUrl) async {
    if (getEnv().isProduction == false) return;
    var isOutdatedResult = await this.isOutdatedVersionCheck();
    bool isUpToDate = !isOutdatedResult.value;
    if (isOutdatedResult.hasFailed || isUpToDate) return;
    getLog().i('Update available');
    this.showUpdateSnackbar(context, externalUrl);
  }

  Future<ResultWithValue<bool>> isOutdatedVersionCheck() async {
    ResultWithValue<PackageInfo> versionResult = await this.currentAppVersion();
    if (versionResult.hasFailed) {
      return ResultWithValue<bool>(false, false, versionResult.errorMessage);
    }

    List<PlatformType> platforms = List<PlatformType>();
    if (isApple) platforms.add(PlatformType.Apple);
    if (isAndroid) platforms.add(PlatformType.Android);
    ResultWithValue<VersionViewModel> serverVersionResult =
        await getAssistantAppsVersions().getLatest(platforms);
    if (serverVersionResult.hasFailed) {
      return ResultWithValue<bool>(
          false, false, serverVersionResult.errorMessage);
    }

    try {
      String localBuildNumber = versionResult.value.buildNumber;
      getLog().i('App: $localBuildNumber');

      int serverBuildNumber = serverVersionResult.value.buildNumber;
      getLog().i('Server buildNumber: $serverBuildNumber');

      if (serverBuildNumber > int.parse(localBuildNumber)) {
        return ResultWithValue<bool>(true, true, 'Outdated');
      }
      return ResultWithValue<bool>(true, false, 'Up to date');
    } catch (exception) {
      getLog().e("versionCheck Exception: ${exception.toString()}");
      return ResultWithValue<bool>(false, false, exception.toString());
    }
  }

  Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
    getLog().i('currentAppVersion');
    bool hasPackageInfo = isAndroid || isiOS;
    if (!hasPackageInfo) {
      return ResultWithValue<PackageInfo>(
          false, PackageInfo(), 'platform not supported');
    }
    try {
      var packInfo = await PackageInfo.fromPlatform();
      return ResultWithValue<PackageInfo>(true, packInfo, '');
    } catch (exception) {
      return ResultWithValue<PackageInfo>(
          false, PackageInfo(), exception.toString());
    }
  }

  void showUpdateSnackbar(BuildContext context, String externalUrl) {
    var storeLocale = isApple ? LocaleKey.appStore : LocaleKey.googlePlay;
    getSnackbar().showSnackbar(
      context,
      LocaleKey.updateAvailable,
      duration: Duration(minutes: 5),
      action: FlatButton(
        child: Text(getTranslations().fromKey(storeLocale)),
        textColor: Colors.black,
        onPressed: () => launchExternalURL(externalUrl),
      ),
    );
  }
}
