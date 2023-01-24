import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget searchBar(context, TextEditingController controller, String? hintText,
        void Function(String) onSearchTextChanged) =>
    _androidSearchBar(context, controller, hintText, onSearchTextChanged);

Widget _androidSearchBar(context, TextEditingController controller,
    String? hintText, void Function(String) onSearchTextChanged) {
  return Container(
    color: getTheme().getPrimaryColour(context),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                const Padding(
                    padding: EdgeInsets.all(16), child: Icon(Icons.search)),
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    cursorColor: getTheme().getSecondaryColour(context),
                    decoration: InputDecoration(
                      hintText: hintText ??
                          getTranslations().fromKey(LocaleKey.searchItems),
                      border: InputBorder.none,
                    ),
                    onChanged: onSearchTextChanged,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                      // FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
