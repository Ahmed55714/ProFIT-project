class PersonalData {
  String? gender;
  String? birthDate;
  double? weight;
  double? height;
  String? activityLevel;

  PersonalData({
    this.gender,
    this.birthDate,
    this.weight,
    this.height,
    this.activityLevel,
  });

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
      gender: json['gender'] as String?,
      birthDate: json['birthDate'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      activityLevel: json['activityLevel'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birthDate': birthDate,
      'weight': weight,
      'height': height,
      'activityLevel': activityLevel,
    };
  }
}
