import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

Widget genericEllipsesText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

Widget genericItemText(String text) => Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );

Widget genericItemName(String name, {maxLines = 3}) => Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
    );

Widget genericItemDescription(String description,
        {TextStyle? textStyle, int maxLines = 10}) =>
    Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: textStyle,
      ),
    );

Widget genericItemGroup(String group, {Key? key, int maxLines = 2}) => //
    Container(
      key: key,
      margin: const EdgeInsets.all(4.0),
      child: Text(
        group,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18),
      ),
    );

TextEditingController maskedTextController({
  required String mask,
  String defaultText = '',
  void Function(String prev, String next)? afterChange,
}) {
  return MaskedTextController(mask: mask, text: defaultText);
}
