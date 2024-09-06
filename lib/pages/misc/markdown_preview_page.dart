import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownPreviewPage extends StatelessWidget {
  final bool showAppBar;
  final String markdownContent;

  const MarkdownPreviewPage(
    this.markdownContent, {
    super.key,
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showAppBar) return Markdown(data: markdownContent);

    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(
          LocaleKey.guideSectionAddMarkdownPreview,
        )),
      ),
      body: Markdown(data: markdownContent),
    );
  }
}
