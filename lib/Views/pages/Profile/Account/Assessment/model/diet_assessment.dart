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
  });

  factory OldDietAssessment.fromJson(Map<String, dynamic> json) {
    return OldDietAssessment(
      calories: json['macros']['calories'],
      proteins: json['macros']['proteins'],
      fats: json['macros']['fats'],
      carbs: json['macros']['carbs'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      height: json['height'],
      foodAllergens: List<String>.from(json['foodAllergens']),
      disease: List<String>.from(json['disease']),
      religionRestriction: List<String>.from(json['religionrestriction']),
      dietType: json['dietType'],
      numberOfMeals: json['numberofmeals'],
      weight: json['weight'],
      bodyFat: json['bodyFat'],
      waistArea: json['waistArea'],
      neckArea: json['neckArea'],
      fitnessGoals: json['fitnessGoals'],
      activityLevel: json['activityLevel'],
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
