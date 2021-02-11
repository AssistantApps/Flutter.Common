import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_formatter/time_formatter.dart';

import '../../assistantapps_flutter_common.dart';
import '../common/icon.dart';

Widget steamNewsItemTilePresenter(
    BuildContext context, SteamNewsItemViewModel newsItem) {
  Widget image = networkImage(
    newsItem.image,
    loading: localImage('${getPath().imageAssetPathPrefix()}/defaultNews.jpg'),
  );
  return GestureDetector(
    child: Card(
      child: Column(
        children: <Widget>[
          image,
          Padding(
            padding: EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Text(
              newsItem.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Text(
              DateFormat(UIConstants.DateFormat).format(newsItem.date) ?? '...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              newsItem.shortDescription,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (newsItem.upVotes != null) ...[
                  iconWithValueRow(Icons.thumb_up, newsItem.upVotes)
                ],
                if (newsItem.downVotes != null) ...[
                  iconWithValueRow(Icons.thumb_down, newsItem.downVotes)
                ],
                if (newsItem.commentCount != null) ...[
                  iconWithValueRow(Icons.comment, newsItem.commentCount)
                ],
              ],
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(4),
    ),
    onTap: () => launchExternalURL(newsItem.link),
  );
}

Widget steamBranchItemTilePresenter(
    BuildContext context, SteamBranchesViewModel branch) {
  String date = branch.lastUpdate == null
      ? '...'
      : DateFormat(UIConstants.DateTimeFormat).format(branch.lastUpdate);
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
        formatTime(branch.lastUpdate.millisecondsSinceEpoch),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
