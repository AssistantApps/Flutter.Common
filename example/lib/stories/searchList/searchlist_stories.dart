import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../constants/storybook_names.dart';

List<Story> getSearchListStories() {
  return [
    Story(
      name: StorybookNames.searchBar,
      description: 'User input for searching',
      builder: (context) => getBaseWidget().appScaffold(
        context,
        appBar: getBaseWidget().appBarForSubPage(
          context,
          showBackAction: false,
          title: const Text('SearchBar'),
        ),
        body: SearchBar(
          controller: TextEditingController(),
          hintText: context.knobs.text(
            label: 'Hint text',
            initial: 'search something',
          ),
          onSearchTextChanged: (_) {},
        ),
      ),
    ),
  ];
}
