// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';

import '../../../../../utils/colors.dart';
import '../../../../services/api_service.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/graph.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/review_card.dart';
import 'model/reviews.dart';

class ReviewSection extends StatefulWidget {
    final String trainerId;
  const ReviewSection({
    Key? key,
    required this.trainerId,
  }) : super(key: key);
  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  double averageRating = 0;
  List<Review> reviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  void fetchReviews() async {
    ReviewsData? reviewsData = await ApiService().fetchTrainerReviews(widget.trainerId);
     
    if (reviewsData != null) {
      setState(() {
        averageRating = reviewsData.averageRating;
        reviews = reviewsData.reviews;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CustomLoder(color: colorBlue) : buildContent();
  }

  Widget buildContent() {
    return Container(
      color: grey50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RatingBar(averageRating),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: RatingGraph(reviews),
              ),
            ],
          ),
          SizedBox(height: 16),
         ...reviews.map((review) => Column(
  children: [
    ReviewCard(
      rating: review.rating.toDouble(),
      comment: review.comment,
      traineeName: review.traineeName, reviewDate: review.date, avatarUrl: review.avatarUrl,
    ),
    SizedBox(height: 16),
  ],
)).toList(),

          SizedBox(height: 224),
        ],
      ),
    );
  }
}
