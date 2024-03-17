import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';

class RatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '3.8',
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
  @override
  Widget build(BuildContext context) {
    List<RatingBarGraph> ratings = List.generate(
        5, (index) => RatingBarGraph(5 - index, (5 - index) * 10));

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
        horizontal: 16,
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
          Text('${percentage.toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: colorDarkBlue,
              )),
        ],
      ),
    );
  }
}
