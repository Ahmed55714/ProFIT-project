import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';
import '../../../../pages/Explore/Reviews/model/reviews.dart';

class RatingBar extends StatelessWidget {
  final double averageRating;

  RatingBar(this.averageRating);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          averageRating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 40,
            color: blue700,
            fontWeight: FontWeight.w700,
            fontFamily: 'BoldCairo',
          ),
        ),
        SvgPicture.asset('assets/svgs/star-1.svg'),
      ],
    );
  }
}


class RatingGraph extends StatelessWidget {
  final List<Review> reviews;

  RatingGraph(this.reviews);

  @override
  Widget build(BuildContext context) {
    // Process reviews to compute the rating distribution
    // Example: count number of each star rating
    Map<int, int> ratingsCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    reviews.forEach((review) {
      ratingsCount[review.rating] = (ratingsCount[review.rating] ?? 0) + 1;
    });
    int totalReviews = reviews.length;

    List<RatingBarGraph> ratings = ratingsCount.entries.map((entry) {
      double percentage = (entry.value / totalReviews) * 100;
      return RatingBarGraph(entry.key, percentage);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView(
        children: ratings,
      ),
    );
  }
}


class RatingBarGraph extends StatelessWidget {
  final int starCount;
  final double percentage;

  RatingBarGraph(this.starCount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Row(
        children: [
          Text('$starCount',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: colorDarkBlue,
              )),
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 230,
                  height: 4,
                  decoration: BoxDecoration(
                    color: grey300,
                    borderRadius:
                        BorderRadius.circular(5), // Adjusted border radius
                  ),
                ),
                Container(
                  width: 230 * (percentage / 100),
                  height: 4, // Decreased height for a more compact look
                  decoration: BoxDecoration(
                    color: blue700,
                    borderRadius:
                        BorderRadius.circular(5), // Adjusted border radius
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text('${percentage.toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: colorDarkBlue,
              )),
              SizedBox(width: 8),
        ],
      ),
    );
  }
}
