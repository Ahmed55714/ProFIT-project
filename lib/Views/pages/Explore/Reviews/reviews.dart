import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/graph.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/review_card.dart';

class ReviewSection extends StatefulWidget {
  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey50,
      child: Column(children: [
        
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: RatingBar(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RatingGraph(),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...List.generate(
          4,
          (index) => Column(
            children: [
              ReviewCard(key: ValueKey(index)),
              SizedBox(height: 16),
            ],
          ),
        ),
        SizedBox(height: 224),
      ]),
    );
  }
}
