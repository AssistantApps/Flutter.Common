import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

Widget genericEllipsesText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

Widget genericItemText(String text) => Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemName(String name, {maxLines = 3}) => Container(
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20),
      ),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemDescription(String description,
        {TextStyle? textStyle, int maxLines = 10}) =>
    Container(
      child: Text(
        description,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: textStyle,
      ),
      margin: const EdgeInsets.all(4.0),
    );

Widget genericItemGroup(String group, {Key? key, int maxLines = 2}) => //
    Container(
      key: key,
      child: Text(
        group,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18),
      ),
      margin: const EdgeInsets.all(4.0),
    );

TextEditingController maskedTextController({
  required String mask,
  String defaultText = '',
  void Function(String prev, String next)? afterChange,
}) {
  return MaskedTextController(mask: mask, text: defaultText);
}
