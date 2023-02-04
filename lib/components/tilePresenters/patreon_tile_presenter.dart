import 'package:flutter/material.dart';

import '../../constants/external_urls.dart';
import '../../contracts/generated/patreon_view_model.dart';
import '../../helpers/external_helper.dart';
import './generic_tile_presenter.dart';

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
