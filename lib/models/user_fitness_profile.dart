class UserFitnessProfile {
  String gender;
  String birthDate;
  int weight;
  int height;
  String fitnessGoals;
  String activityLevel;

  UserFitnessProfile({
    this.gender = '',
    this.birthDate = '',
    this.weight = 0,
    this.height = 0,
    this.fitnessGoals = '',
    this.activityLevel = '',
  });

  Map<String, dynamic> toJson() => {
        'gender': gender,
        'birthDate': birthDate,
        'weight': weight,
        'height': height,
        'fitnessGoals': fitnessGoals,
        'activityLevel': activityLevel,
      };
}
