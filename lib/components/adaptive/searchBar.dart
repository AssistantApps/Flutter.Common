import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget searchBar(
        context,
        TextEditingController controller,
        Color primaryColour,
        Color secondaryColour,
        String hintText,
        String searchItems,
        void Function(String) onSearchTextChanged) =>
    _androidSearchBar(context, controller, primaryColour, secondaryColour,
        hintText, searchItems, onSearchTextChanged);

Widget _androidSearchBar(
    context,
    TextEditingController controller,
    Color primaryColour,
    Color secondaryColour,
    String hintText,
    String searchItems,
    void Function(String) onSearchTextChanged) {
  return Container(
    color: primaryColour,
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            controller: controller,
            cursorColor: secondaryColour,
            decoration: InputDecoration(
                hintText: hintText == null ? searchItems : hintText,
                border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
        ),
      ),
    ),
  );
}
