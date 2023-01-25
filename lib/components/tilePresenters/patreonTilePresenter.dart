import 'package:flutter/material.dart';

import '../../constants/ExternalUrls.dart';
import '../../contracts/generated/patreonViewModel.dart';
import '../../helpers/externalHelper.dart';
import './genericTilePresenter.dart';

Widget patronTilePresenter(
  BuildContext context,
  PatreonViewModel patron, {
  void Function()? onTap,
}) {
  if (patron.url == ExternalUrls.patreon) {
    localOnTap() => launchExternalURL(patron.url);
    return Card(
      child: genericListTileWithNetworkImage(
        context,
        imageUrl: patron.imageUrl,
        name: patron.name,
        onTap: localOnTap,
        trailing: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: localOnTap,
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
