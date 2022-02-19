import 'package:flutter/material.dart';

import '../../constants/PaddingConstant.dart';
import '../../constants/UIConstants.dart';

Widget commonCard(Widget imageWidget, Widget bodyWidget, {Function()? onTap}) {
  return wrapInCommonCard(
    Column(
      children: [
        imageWidget,
        Padding(
          padding: const EdgeInsets.all(16),
          child: bodyWidget,
        ),
      ],
    ),
    onTap: onTap,
  );
}

Widget wrapInCommonCard(Widget bodyWidget, {Function()? onTap}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: InkWell(
      child: Padding(
        padding: PaddingConstant.commonCard,
        child: bodyWidget,
      ),
      onTap: onTap,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: const EdgeInsets.all(4),
  );
}

Widget flatCard({Widget? child, Color? shadowColor}) {
  return Card(
    child: child,
    margin: const EdgeInsets.all(0.0),
    shape: UIConstants.noBorderRadius,
    shadowColor: shadowColor,
  );
}

// Widget commonCardDetailedBody(BuildContext context, String title, String body,
//     {DateTime date}) {
//   return Stack(
//     children: [
//       Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Flex(
//               direction: Axis.horizontal,
//               children: [
//                 Flexible(
//                   flex: 7,
//                   child: Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 3,
//                   child: Container(width: 0, height: 0),
//                 )
//               ],
//             ),
//           ),
//           Text(
//             body,
//             maxLines: 3,
//             style: TextStyle(color: getCardTextColour(context)),
//           ),
//         ],
//       ),
//       if (date != null) ...[
//         Positioned(
//           child: Text(
//             getDateTimeString(date),
//             textAlign: TextAlign.end,
//           ),
//           top: 4,
//           right: 0,
//         ),
//       ],
//     ],
//   );
// }
