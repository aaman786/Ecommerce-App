// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Star extends StatelessWidget {
  final double ratting;
  const Star({
    Key? key,
    required this.ratting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: ratting,
      itemSize: 15,
      itemBuilder: (context, _) {
        return const Icon(Icons.star);
      },
    );
  }
}
