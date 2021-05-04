import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String helpContent;
  final String analyticsKey;
  ImageViewerPage(
    this.name,
    this.imageUrl, {
    this.analyticsKey,
    this.helpContent,
  }) {
    getAnalytics().trackEvent(this.analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    String localImage = this.imageUrl;
    if (!localImage.contains('http') &&
        !localImage.contains(getPath().imageAssetPathPrefix)) {
      localImage = '${getPath().imageAssetPathPrefix}/${this.imageUrl}';
    }

    return getBaseWidget().appScaffold(context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          title: Text(this.name ?? 'Zoom'),
          actions: helpContent != null
              ? [
                  ActionItem(
                    icon: Icons.help_outline,
                    onPressed: () => getDialog().showSimpleHelpDialog(
                      context,
                      getTranslations().fromKey(LocaleKey.help),
                      helpContent,
                    ),
                  )
                ]
              : null,
        ),
        body: Container(
            child: PhotoView(
          loadingBuilder: (BuildContext innerContext, __) =>
              getLoading().fullPageLoading(innerContext),
          imageProvider: this.imageUrl.contains('http')
              ? NetworkImage(this.imageUrl)
              : AssetImage(localImage),
          maxScale: PhotoViewComputedScale.covered * 2,
          minScale: PhotoViewComputedScale.contained * 0.75,
          initialScale: PhotoViewComputedScale.contained,
        )));
  }
}
