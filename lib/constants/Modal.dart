import 'package:flutter/material.dart';

BoxConstraints modalDefaultSize(BuildContext context) {
  return BoxConstraints(
    minHeight: (MediaQuery.of(context).size.height) / 2,
    maxHeight: (MediaQuery.of(context).size.height) * 0.9,
  );
}

BoxConstraints modalMiniSize(BuildContext context) {
  return BoxConstraints(
    minHeight: (MediaQuery.of(context).size.height) / 2,
    maxHeight: (MediaQuery.of(context).size.height) * 0.75,
  );
}

BoxConstraints modalFullHeightSize(BuildContext context) {
  return BoxConstraints(
    minHeight: (MediaQuery.of(context).size.height) / 2,
  );
}
