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
