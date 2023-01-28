import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  final bool hideShortText;
  final bool hideLongText;

  const ListTileShimmer({
    Key? key,
    this.hideShortText = false,
    this.hideLongText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[800]!,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!hideShortText) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Container(
                      width: 100,
                      height: 14.0,
                      color: Colors.white,
                    ),
                  ],
                  if (!hideLongText) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Container(
                      width: 170.0,
                      height: 10.0,
                      color: Colors.white,
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
