import 'package:flutter/material.dart';

import '../../helpers/externalHelper.dart';
import '../common/image.dart';

Widget externalLinkPresenter(BuildContext context, String name, String url) {
  return ListTile(
    title: Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      url,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: getCorrectlySizedImageFromIcon(context, Icons.open_in_new),
    onTap: () => launchExternalURL(url),
  );
}
