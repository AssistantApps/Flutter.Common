import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_duration.dart';
import '../../constants/modal.dart';
import '../../integration/dependency_injection.dart';

class VersionDebugBottomSheet extends StatelessWidget {
  const VersionDebugBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedFutureBuilder(
      future: getUpdate().getPackageInfo(),
      whileLoading: () => getLoading().smallLoadingTile(context),
      whenDoneLoading: (ResultWithValue<VersionDetail> versionData) {
        List<Widget> widgets = List.empty(growable: true);
        widgets.add(const EmptySpace3x());

        String buildNum = versionData.isSuccess //
            ? versionData.value.buildNumber
            : '';
        String buildName = versionData.isSuccess //
            ? versionData.value.version
            : '';
        String commitHash = getEnv().commitHash ?? '';
        String githubViewAppRepoAtCommit =
            getEnv().githubViewAppRepoAtCommit ?? '';
        String currentWhatIsNewGuid = getEnv().currentWhatIsNewGuid;
        int? appVersionBuildNumberOverride =
            getEnv().appVersionBuildNumberOverride;
        String appVerBuildNameOverride =
            getEnv().appVersionBuildNameOverride ?? '';

        if (buildNum.isNotEmpty) {
          widgets.add(ListTile(
            title: const Text('BuildNum:'),
            subtitle: Text(buildNum),
          ));
        }

        if (buildName.isNotEmpty) {
          widgets.add(ListTile(
            title: const Text('BuildName:'),
            subtitle: Text(buildName),
          ));
        }

        if (appVersionBuildNumberOverride != null) {
          widgets.add(ListTile(
            title: const Text('Version build number override:'),
            subtitle: Text(appVersionBuildNumberOverride.toString()),
          ));
        }

        if (appVerBuildNameOverride.isNotEmpty) {
          widgets.add(ListTile(
            title: const Text('Version build name override:'),
            subtitle: Text(appVerBuildNameOverride),
          ));
        }

        if (commitHash.isNotEmpty && githubViewAppRepoAtCommit.isNotEmpty) {
          widgets.add(ListTile(
            title: const Text('Commit hash:'),
            subtitle: Text(
              getEnv().commitHash!,
              maxLines: 3,
              style: const TextStyle(color: Colors.blue),
            ),
            trailing: const Icon(Icons.open_in_new_rounded),
            onTap: () => launchExternalURL(
              githubViewAppRepoAtCommit + commitHash,
            ),
          ));
        }

        widgets.add(ListTile(
          title: const Text('Current "What is New" guid:'),
          subtitle: Text(currentWhatIsNewGuid),
        ));

        widgets.add(const EmptySpace10x());

        return AnimatedSize(
          duration: AppDuration.modal,
          child: Container(
            constraints: modalMiniSize(context),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: widgets.length,
              itemBuilder: (_, int index) => widgets[index],
              shrinkWrap: true,
              controller: ScrollController(),
            ),
          ),
        );
      },
    );
  }
}
