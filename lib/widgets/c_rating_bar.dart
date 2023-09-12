import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/colors.dart';

class CRatingBar extends StatelessWidget {
  const CRatingBar({
    Key? key,
     this.onUpdate,
    required this.rating,
    this.itemSize = 18,
    this.ignoreGesture = false,
  }) : super(key: key);

  final double rating;
  final void Function(double)? onUpdate;
  final double itemSize;
  final bool ignoreGesture;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGesture,
      itemSize: itemSize,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        size: 10,
        color: CColors.rating,
      ),
      onRatingUpdate: onUpdate  ?? (value){},
    );
  }
}
