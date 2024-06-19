class DietPlanActive {
  final String? id;
  final String? planName;
  final String? trainer;
  final String? trainee;
  final String? plantype;
  final bool? published;
  final String? status;
  final List<Day> days;

  DietPlanActive({
    required this.id,
    required this.planName,
    required this.trainer,
    required this.trainee,
    required this.plantype,
    required this.published,
    required this.status,
    required this.days,
  });

  factory DietPlanActive.fromJson(Map<String, dynamic> json) {
    return DietPlanActive(
      id: json['_id'],
      planName: json['planName'],
      trainer: json['trainer'],
      trainee: json['trainee'],
      plantype: json['plantype'],
      published: json['published'],
      status: json['status'],
      days: (json['days'] as List).map((i) => Day.fromJson(i)).toList(),
    );
  }
}

class Day {
  final String? day;
  final List<Meal> meals;

  Day({required this.day, required this.meals});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      day: json['day'],
      meals: (json['meals'] as List).map((i) => Meal.fromJson(i)).toList(),
    );
  }
}

class Meal {
  final String? id;
  final String? mealType;
  final String? mealName;

  Meal({required this.id, required this.mealType, required this.mealName});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['_id'],
      mealType: json['mealType'],
      mealName: json['mealName'],
    );
  }
}
