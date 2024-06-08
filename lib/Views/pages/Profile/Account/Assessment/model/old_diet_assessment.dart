class OldDietAssessmentInformation {
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;
  final String gender;
  final DateTime birthDate;
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
  final DateTime createdAt;
  final DateTime updatedAt;

  OldDietAssessmentInformation({
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

  factory OldDietAssessmentInformation.fromJson(Map<String, dynamic> json) {
    return OldDietAssessmentInformation(
      calories: json['macros']['calories'] ?? 0,
      proteins: json['macros']['proteins'] ?? 0,
      fats: json['macros']['fats'] ?? 0,
      carbs: json['macros']['carbs'] ?? 0,
      gender: json['gender'] ?? '',
      birthDate: DateTime.parse(json['birthDate']),
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}