import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String? helpContent;
  final String analyticsKey;

  ImageViewerPage(
    this.name,
    this.imageUrl, {
    Key? key,
    required this.analyticsKey,
    this.helpContent,
  }) : super(key: key) {
    getAnalytics().trackEvent(analyticsKey);
  }

  @override
  Widget build(BuildContext context) {
    String localImage = imageUrl;
    if (!localImage.contains('http') &&
        !localImage.contains('assets/') &&
        !localImage.contains(getPath().imageAssetPathPrefix)) {
      localImage = getPath().ofImage(imageUrl);
    }

    dynamic imageProvider = imageUrl.contains('http')
        ? NetworkImage(imageUrl)
        : AssetImage(localImage);

    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        title: Text(name),
        showHomeAction: true,
        actions: helpContent != null
            ? [
                ActionItem(
                  icon: Icons.help_outline,
                  onPressed: () => getDialog().showSimpleHelpDialog(
                    context,
                    getTranslations().fromKey(LocaleKey.help),
                    helpContent!,
                  ),
                )
              ]
            : null,
      ),
      body: PhotoView(
        loadingBuilder: (BuildContext innerContext, __) =>
            getLoading().fullPageLoading(innerContext),
        imageProvider: imageProvider,
        maxScale: PhotoViewComputedScale.covered * 2,
        minScale: PhotoViewComputedScale.contained * 0.75,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
