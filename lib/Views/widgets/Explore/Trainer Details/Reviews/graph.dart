import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';
import '../../../../pages/Explore/Reviews/model/reviews.dart';

class AnimatedRatingBar extends StatefulWidget {
  final double averageRating;

  const AnimatedRatingBar(this.averageRating, {Key? key}) : super(key: key);

  @override
  _AnimatedRatingBarState createState() => _AnimatedRatingBarState();
}

class _AnimatedRatingBarState extends State<AnimatedRatingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.averageRating).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _animation.value.toStringAsFixed(1),
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
      },
    );
  }
}

class RatingGraph extends StatelessWidget {
  final List<Review> reviews;

  RatingGraph(this.reviews);

  @override
  Widget build(BuildContext context) {
    // Process reviews to compute the rating distribution
    Map<int, int> ratingsCount = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    reviews.forEach((review) {
      ratingsCount[review.rating] = (ratingsCount[review.rating] ?? 0) + 1;
    });
    int totalReviews = reviews.length;

    List<AnimatedRatingBarGraph> ratings = ratingsCount.entries.map((entry) {
      double percentage = totalReviews > 0 ? (entry.value / totalReviews) * 100 : 0;
      return AnimatedRatingBarGraph(starCount: entry.key, percentage: percentage);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView(
        children: ratings,
      ),
    );
  }
}

class AnimatedRatingBarGraph extends StatefulWidget {
  final int starCount;
  final double percentage;

  const AnimatedRatingBarGraph({
    Key? key,
    required this.starCount,
    required this.percentage,
  }) : super(key: key);

  @override
  _AnimatedRatingBarGraphState createState() => _AnimatedRatingBarGraphState();
}

class _AnimatedRatingBarGraphState extends State<AnimatedRatingBarGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text('${widget.starCount}',
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      width: 230 * (_animation.value / 100),
                      height: 4,
                      decoration: BoxDecoration(
                        color: blue700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text('${widget.percentage.toInt()}%',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: colorDarkBlue,
              )),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
