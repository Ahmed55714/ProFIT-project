class OldDietAssessment {
  String dietAssessmentId;
  String createdAt;
  String dietAssessmentData;

  OldDietAssessment({
    required this.dietAssessmentId,
    required this.createdAt,
    required this.dietAssessmentData,
  });

  factory OldDietAssessment.fromJson(Map<String, dynamic> json) {
    return OldDietAssessment(
      dietAssessmentId: json['DietAssessmentId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      dietAssessmentData: json['DietAssessmentData'] ?? '',
    );
  }
}
