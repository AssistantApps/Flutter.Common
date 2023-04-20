import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class AdaptiveSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final void Function(String) onSearchTextChanged;

  const AdaptiveSearchBar({
    Key? key,
    required this.controller,
    this.hintText,
    required this.onSearchTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getTheme().getPrimaryColour(context),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Flex(
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
                  onChanged: (String text) => onSearchTextChanged(
                    text.trim(),
                  ),
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
        ),
      ),
    );
  }
}
