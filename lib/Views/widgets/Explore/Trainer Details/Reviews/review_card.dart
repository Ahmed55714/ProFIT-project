import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../Trainers/free_diet.dart';



class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: grey200, 
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/svgs/star-2.svg'),
                 SizedBox(width: 4),
                Text(
                  '4.0',
                  style: TextStyle(
                    color: greenReview,
                    fontWeight: FontWeight.w700,
                    
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            CustomTextWidget(
              text:
                  'Hey bro.,l\'ve just received my program..lemme tell you that from the first moment I fell in love with it..honestly it\'s done with great care and love and made me feel how I was fooled for three months by my current coach who was for sure the reason behind my shoulder injury..seriously I felt that',
              color: Colors.black,

            ),
            SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with actual image URL
                  radius: 25,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fares Mohamed',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colorDarkBlue,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      '14 Dec, 2022',
                      style: TextStyle(
                        color: grey500,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}