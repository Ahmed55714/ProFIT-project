class NutritionPlan {
  final String id;
  final String planName;
  final String dietType;
  final String description;
  final int calories;
  final int proteins;
  final int carbs;
  final double fats;
  final double rating;
  final int reviewCount;
  final String goal;
  final String duration;
  final int mealsCount;
  final bool isFavorite;
  final String name;
  final String profilePhoto;

  NutritionPlan({
    required this.id,
    required this.planName,
    required this.dietType,
    required this.description,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.rating,
    required this.reviewCount,
    required this.goal,
    required this.duration,
    required this.mealsCount,
    required this.isFavorite,
    required this.name,
    required this.profilePhoto,
  });

  factory NutritionPlan.fromJson(Map<String, dynamic> json) {
    return NutritionPlan(
      id: json['_id'] ?? '',
      planName: json['planName'] ?? '',
      dietType: json['dietType'] ?? '',
      description: json['description'] ?? '',
      calories: (json['calories'] ?? 0).toInt(),
      proteins: (json['proteins'] ?? 0).toInt(),
      carbs: (json['carbs'] ?? 0).toInt(),
      fats: (json['fats'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      goal: json['goal'] ?? '',
      duration: json['duration'] ?? '',
      mealsCount: json['mealsCount'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      name: json['name'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
    );
  }
}
