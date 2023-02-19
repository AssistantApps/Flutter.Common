import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class GenericEllipsesText extends StatelessWidget {
  final String text;

  const GenericEllipsesText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class GenericItemText extends StatelessWidget {
  final String text;

  const GenericItemText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class GenericItemName extends StatelessWidget {
  final String name;
  final int? maxLines;

  const GenericItemName(
    this.name, {
    Key? key,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class GenericItemDescription extends StatelessWidget {
  final String description;
  final TextStyle? textStyle;
  final int? maxLines;

  const GenericItemDescription(
    this.description, {
    Key? key,
    this.textStyle,
    this.maxLines = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        maxLines: maxLines,
        style: textStyle,
      ),
    );
  }
}

class GenericItemGroup extends StatelessWidget {
  final String group;
  final int? maxLines;

  const GenericItemGroup(
    this.group, {
    Key? key,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      margin: const EdgeInsets.all(4.0),
      child: Text(
        group,
        maxLines: maxLines,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

TextEditingController maskedTextController({
  required String mask,
  String defaultText = '',
  void Function(String prev, String next)? afterChange,
}) {
  return MaskedTextController(mask: mask, text: defaultText);
}
