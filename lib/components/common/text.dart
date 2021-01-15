import 'package:flutter/material.dart';

Widget genericEllipsesText(String text) => Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
