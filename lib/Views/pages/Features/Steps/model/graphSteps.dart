class WeeklySteps {
  final int steps;
  final int calories;
  final DateTime createdAt;

  WeeklySteps({
    required this.steps,
    required this.calories,
    required this.createdAt,
  });

  factory WeeklySteps.fromJson(Map<String, dynamic> json) {
    return WeeklySteps(
      steps: json['steps'],
      calories: json['calories'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
