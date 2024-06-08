class DietPlan {
  String planName;
  String? dietType;
  String description;
  double calories;
  double proteins;
  double carbs;
  double fats;
  double rating;
  int reviewCount;
  String goal;
  String duration;
  int meals;
  bool isFavorite;

  DietPlan({
    required this.planName,
    this.dietType,
    required this.description,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.rating,
    required this.reviewCount,
    required this.goal,
    required this.duration,
    required this.meals,
    required this.isFavorite,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      planName: json['planName'] ?? '',
      dietType: json['dietType'],
      description: json['description'] ?? '',
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      goal: json['goal'] ?? '',
      duration: json['duration'] ?? '',
      meals: json['meals'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
