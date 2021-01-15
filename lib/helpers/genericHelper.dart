import 'package:flutter/material.dart';

Widget emptySpace(double multiplier) =>
    Container(margin: EdgeInsets.all(multiplier * 4));

Widget genericItemText(String text) => Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
      margin: const EdgeInsets.all(4.0),
    );
