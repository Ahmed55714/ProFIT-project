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

  NutritionPlan copyWith({
    String? id,
    String? planName,
    String? dietType,
    String? description,
    int? calories,
    int? proteins,
    int? carbs,
    double? fats,
    double? rating,
    int? reviewCount,
    String? goal,
    String? duration,
    int? mealsCount,
    bool? isFavorite,
    String? name,
    String? profilePhoto,
  }) {
    return NutritionPlan(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      dietType: dietType ?? this.dietType,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      proteins: proteins ?? this.proteins,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      goal: goal ?? this.goal,
      duration: duration ?? this.duration,
      mealsCount: mealsCount ?? this.mealsCount,
      isFavorite: isFavorite ?? this.isFavorite,
      name: name ?? this.name,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
