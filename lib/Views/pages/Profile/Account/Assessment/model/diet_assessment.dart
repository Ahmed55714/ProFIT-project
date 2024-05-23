class OldDietAssessment {
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;
  final String gender;
  final String birthDate;
  final int height;
  final List<String> foodAllergens;
  final List<String> disease;
  final List<String> religionRestriction;
  final String dietType;
  final int numberOfMeals;
  final int weight;
  final int bodyFat;
  final int waistArea;
  final int neckArea;
  final String fitnessGoals;
  final String activityLevel;
  final String status;
  final List<String> documents;
  final String createdAt;
  final String updatedAt;

  OldDietAssessment({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    required this.gender,
    required this.birthDate,
    required this.height,
    required this.foodAllergens,
    required this.disease,
    required this.religionRestriction,
    required this.dietType,
    required this.numberOfMeals,
    required this.weight,
    required this.bodyFat,
    required this.waistArea,
    required this.neckArea,
    required this.fitnessGoals,
    required this.activityLevel,
    required this.status,
    required this.documents,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OldDietAssessment.fromJson(Map<String, dynamic> json) {
    return OldDietAssessment(
      calories: json['macros']['calories'] ?? 0,
      proteins: json['macros']['proteins'] ?? 0,
      fats: json['macros']['fats'] ?? 0,
      carbs: json['macros']['carbs'] ?? 0,
      gender: json['gender'] ?? '',
      birthDate: json['birthDate'] ?? '',
      height: json['height'] ?? 0,
      foodAllergens: List<String>.from(json['foodAllergens'] ?? []),
      disease: List<String>.from(json['disease'] ?? []),
      religionRestriction: List<String>.from(json['religionrestriction'] ?? []),
      dietType: json['dietType'] ?? '',
      numberOfMeals: json['numberofmeals'] ?? 0,
      weight: json['weight'] ?? 0,
      bodyFat: json['bodyFat'] ?? 0,
      waistArea: json['waistArea'] ?? 0,
      neckArea: json['neckArea'] ?? 0,
      fitnessGoals: json['fitnessGoals'] ?? '',
      activityLevel: json['activityLevel'] ?? '',
      status: json['status'] ?? '',
      documents: List<String>.from(json['documents'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}



class DietAssessment {
  List<String>? gender;
  List<String>? fitnessGoals;
  List<String>? activityLevel;
  List<String>? foodAllergens;
  List<String>? disease;
  List<String>? religionRestriction;
  List<String>? dietType;
  List<int>? numberofmeals;

  DietAssessment({
    this.gender,
    this.fitnessGoals,
    this.activityLevel,
    this.foodAllergens,
    this.disease,
    this.religionRestriction,
    this.dietType,
    this.numberofmeals,
  });

  factory DietAssessment.fromJson(Map<String, dynamic> json) {
    return DietAssessment(
      gender: List<String>.from(json['gender'] ?? []),
      fitnessGoals: List<String>.from(json['fitnessGoals'] ?? []),
      activityLevel: List<String>.from(json['activityLevel'] ?? []),
      foodAllergens: List<String>.from(json['foodAllergens'] ?? []),
      disease: List<String>.from(json['disease'] ?? []),
      religionRestriction: List<String>.from(json['religionRestriction'] ?? []),
      dietType: List<String>.from(json['dietType'] ?? []),
      numberofmeals: List<int>.from(json['numberofmeals'] ?? []),
    );
  }
}
