import 'package:flutter/material.dart';

Widget emptySpace(double multiplier) =>
    Container(margin: EdgeInsets.all(multiplier * 4));
Widget emptySpace1x() => emptySpace(1.0);
Widget emptySpace2x() => emptySpace(2.0);
Widget emptySpace3x() => emptySpace(3.0);
Widget emptySpace8x() => emptySpace(8.0);
Widget emptySpace10x() => emptySpace(10.0);
