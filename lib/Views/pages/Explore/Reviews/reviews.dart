import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
  double averageRating = 0.0;
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
        averageRating = reviewsData.averageRating.toDouble();
        reviews = reviewsData.reviews;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? _buildShimmerLoading() : buildContent();
  }

  Widget buildContent() {
    return Container(
      color: grey50,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AnimatedRatingBar(averageRating),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.76,
                child: RatingGraph(reviews),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...reviews
              .map((review) => Column(
                    children: [
                      ReviewCard(
                        rating: review.rating.toDouble(),
                        comment: review.comment,
                        traineeName: review.traineeName,
                        reviewDate: review.date,
                        avatarUrl: review.avatarUrl,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ))
              .toList(),
          const SizedBox(height: 224),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(3, (index) => _buildShimmerReviewCard()).toList(),
          const SizedBox(height: 224),
        ],
      ),
    );
  }

  Widget _buildShimmerReviewCard() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
