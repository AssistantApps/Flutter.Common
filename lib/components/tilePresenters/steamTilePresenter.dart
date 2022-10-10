import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/UIConstants.dart';
import '../../contracts/generated/steamBranchesViewModel.dart';
import '../../contracts/generated/steamNewsItemViewModel.dart';
import '../../helpers/dateHelper.dart';
import '../../helpers/externalHelper.dart';
import '../../integration/dependencyInjection.dart';
import '../common/card.dart';
import '../common/icon.dart';
import '../common/image.dart';

Widget steamNewsItemTilePresenter(
  BuildContext context,
  SteamNewsItemViewModel newsItem,
  int index, {
  void Function()? onTap,
}) {
  Widget image = networkImage(
    newsItem.image,
    boxfit: BoxFit.fitWidth,
    loading: getPath().steamNewsDefaultImage,
  );
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: InkWell(
      child: Column(
        children: <Widget>[
          image,
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
            child: Text(
              newsItem.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Text(
              DateFormat(UIConstants.DateFormat)
                  .format(newsItem.date.toLocal()),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              newsItem.shortDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                iconWithValueRow(Icons.thumb_up, newsItem.upVotes),
                iconWithValueRow(Icons.thumb_down, newsItem.downVotes),
                iconWithValueRow(Icons.comment, newsItem.commentCount),
              ],
            ),
          ),
        ],
      ),
      onTap: () => launchExternalURL(newsItem.link),
    ),
    margin: const EdgeInsets.all(4),
  );
}

Widget steamBranchItemTilePresenter(
    BuildContext context, SteamBranchesViewModel branch) {
  // ignore: unnecessary_null_comparison
  String date = branch.lastUpdate == null
      ? '...'
      : DateFormat(UIConstants.DateTimeFormat).format(
          branch.lastUpdate.toLocal(),
        );
  return flatCard(
    child: ListTile(
      title: Text(
        branch.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '$date - BuildId: ${branch.buildId}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        friendlyTimeSince(branch.lastUpdate),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
