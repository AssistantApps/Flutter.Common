import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int currentRating;
  final double size;
  final void Function(int)? onTap;

  const StarRating({
    Key? key,
    required this.currentRating,
    this.size = 32,
    this.onTap,
  }) : super(key: key);

  @override
  createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int? currentRating;

  @override
  initState() {
    super.initState();
    currentRating = widget.currentRating;
  }

  @override
  Widget build(BuildContext context) {
    //
    localOnTap(int newIndex) {
      if (widget.onTap != null) {
        widget.onTap!(newIndex);
      }
      setState(() {
        currentRating = newIndex;
      });
    }

    Color colour = getTheme().getSecondaryColour(context);
    return Wrap(
      // alignment: WrapAlignment.center,
      children: List.generate(
        5,
        (int index) => GestureDetector(
          child: Icon(
            (index < (currentRating ?? 0)) //
                ? Icons.star
                : Icons.star_border,
            color: colour,
            size: widget.size,
          ),
          onTap: () => localOnTap(index + 1),
        ),
      ),
    );
  }
}
