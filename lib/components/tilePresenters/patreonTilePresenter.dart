import 'package:flutter/material.dart';

import '../../constants/ExternalUrls.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../helpers/externalHelper.dart';
import './genericTilePresenter.dart';

Widget patronTilePresenter(BuildContext context, PatreonViewModel patron) {
  if (patron.url == ExternalUrls.patreon) {
    Function() onTap = () => launchExternalURL(patron.url);
    return Card(
      child: genericListTileWithNetworkImage(
        context,
        imageUrl: patron.imageUrl,
        name: patron.name,
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: onTap,
        ),
      ),
    );
  }
  return genericListTileWithNetworkImage(
    context,
    imageUrl: patron.imageUrl,
    name: patron.name,
  );
}
