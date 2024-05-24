class UserFitnessProfile {
  String gender;
  String birthDate;
  int weight;
  int height;
  String fitnessGoals;
  String activityLevel;

  UserFitnessProfile({
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.fitnessGoals,
    required this.activityLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthDate': birthDate,
      'weight': weight,
      'height': height,
      'fitnessGoals': fitnessGoals,
      'activityLevel': activityLevel,
    };
  }
}
