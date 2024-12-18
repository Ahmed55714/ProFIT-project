class Review {
  final int rating;
  final String comment;
  final String date;
  final String traineeName;
  final bool isCurrentUser;
  final String avatarUrl;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.traineeName,
    required this.isCurrentUser,
    required this.avatarUrl,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      traineeName: json['traineeName'],
      isCurrentUser: json['isCurrentUser'],
      avatarUrl: json['profilePhoto'],
    );
  }
}


class ReviewsData {
  final double averageRating;
  final Map<String, int> ratingsDistribution;
  final List<Review> reviews;
  

  ReviewsData({
    required this.averageRating,
    required this.ratingsDistribution,
    required this.reviews,
  });

  factory ReviewsData.fromJson(Map<String, dynamic> json) {
    return ReviewsData(
      averageRating: (json['averageRating'] as num).toDouble(),
      ratingsDistribution: Map<String, int>.from(json['ratingsDistribution']),
      reviews: List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),

    );
  }
}
