import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/ui_constants.dart';
import '../../contracts/generated/steam_branches_view_model.dart';
import '../../contracts/generated/steam_news_item_view_model.dart';
import '../../helpers/date_helper.dart';
import '../../helpers/external_helper.dart';
import '../../integration/dependency_injection.dart';
import '../common/card.dart';
import '../common/icon.dart';
import '../common/image.dart';

Widget steamNewsItemTilePresenter(
  BuildContext context,
  SteamNewsItemViewModel newsItem,
  int index, {
  void Function()? onTap,
}) {
  Widget image = ImageFromNetwork(
    imageUrl: newsItem.image,
    boxfit: BoxFit.fitWidth,
    loading: getPath().steamNewsDefaultImage,
  );
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.all(4),
    child: InkWell(
      child: Column(
        children: <Widget>[
          image,
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
            child: Text(
              newsItem.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Text(
              DateFormat(UIConstants.dateFormat)
                  .format(newsItem.date.toLocal()),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              newsItem.shortDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconWithValueRow(Icons.thumb_up, newsItem.upVotes),
                IconWithValueRow(Icons.thumb_down, newsItem.downVotes),
                IconWithValueRow(Icons.comment, newsItem.commentCount),
              ],
            ),
          ),
        ],
      ),
      onTap: () => launchExternalURL(newsItem.link),
    ),
  );
}

Widget steamBranchItemTilePresenter(
    BuildContext context, SteamBranchesViewModel branch) {
  // ignore: unnecessary_null_comparison
  String date = branch.lastUpdate == null
      ? '...'
      : DateFormat(UIConstants.dateTimeFormat).format(
          branch.lastUpdate.toLocal(),
        );
  return FlatCard(
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
