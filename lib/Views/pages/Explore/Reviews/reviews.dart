import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/review_card.dart';

class ReviewSection extends StatefulWidget {
  
  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  Widget build(BuildContext context) {
    return 
      Column(
          children: [
            
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

                 
       ]);
    
  }
}

