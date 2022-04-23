import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/StorybookNames.dart';

List<Story> getSearchListStories() {
  return [
    Story(
      name: StorybookNames.SearchBar,
      description: 'User input for searching',
      builder: (context) => getBaseWidget().appScaffold(
        context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          showBackAction: false,
          title: Text('SearchBar'),
        ),
        body: searchBar(
          context,
          TextEditingController(),
          context.knobs.text(
            label: 'Hint text',
            initial: 'search something',
          ),
          (_) {},
        ),
      ),
    ),
  ];
}
