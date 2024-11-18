import '../../../Tabs/Diet/model/free_palns.dart';

class DietPlanOverviewModel {
  final PlanMacros planMacros;
  final TargetMacros targetMacros;
  final String id;
  final String planName;
  final String trainer;
  final int daysCount;
  final List<dynamic> foodAllergens;
  final List<dynamic> disease;
  final List<dynamic> religionRestriction;
  final String description;
  final List<Day> days;
  final String planType;
  final bool published;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  DietPlanOverviewModel({
    required this.planMacros,
    required this.targetMacros,
    required this.id,
    required this.planName,
    required this.trainer,
    required this.daysCount,
    required this.foodAllergens,
    required this.disease,
    required this.religionRestriction,
    required this.description,
    required this.days,
    required this.planType,
    required this.published,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DietPlanOverviewModel.fromJson(Map<String, dynamic> json) {
    return DietPlanOverviewModel(
      planMacros: PlanMacros.fromJson(json['planmacros'] ?? {}),
      targetMacros: TargetMacros.fromJson(json['targetmacros'] ?? {}),
      id: json['_id'] ?? '',
      planName: json['planName'] ?? '',
      trainer: json['trainer'] ?? '',
      daysCount: json['daysCount'] ?? 0,
      foodAllergens: json['foodAllergens'] != null
          ? List<dynamic>.from(json['foodAllergens'])
          : [],
      disease: json['disease'] != null ? List<dynamic>.from(json['disease']) : [],
      religionRestriction: json['religionrestriction'] != null
          ? List<dynamic>.from(json['religionrestriction'])
          : [],
      description: json['description'] ?? '',
      days: json['days'] != null
          ? List<Day>.from(json['days'].map((day) => Day.fromJson(day)))
          : [],
      planType: json['plantype'] ?? '',
      published: json['published'] ?? false,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}

class TargetMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  TargetMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory TargetMacros.fromJson(Map<String, dynamic> json) {
    return TargetMacros(
      calories: (json['calories'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
    );
  }
}

class Day {
  final DayMacros dayMacros;
  final EatenDaysMacros eatenDaysMacros;
  final String day;
  final List<Meal> meals;
  final int mealsCount;
  final String id;
  final DateTime startDate;

  Day({
    required this.dayMacros,
    required this.eatenDaysMacros,
    required this.day,
    required this.meals,
    required this.mealsCount,
    required this.id,
    required this.startDate,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      dayMacros: DayMacros.fromJson(json['daymacros'] ?? {}),
      eatenDaysMacros: EatenDaysMacros.fromJson(json['eatenDaysMacros'] ?? {}),
      day: json['day'] ?? '',
      meals: json['meals'] != null
          ? List<Meal>.from(json['meals'].map((meal) => Meal.fromJson(meal)))
          : [],
      mealsCount: json['mealsCount'] ?? 0,
      id: json['_id'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
    );
  }
}

class DayMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  DayMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory DayMacros.fromJson(Map<String, dynamic> json) {
    return DayMacros(
      calories: (json['calories'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
    );
  }
}

class EatenDaysMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  EatenDaysMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory EatenDaysMacros.fromJson(Map<String, dynamic> json) {
    return EatenDaysMacros(
      calories: (json['calories'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
    );
  }
}

class Meal {
  final MealMacros mealMacros;
  final String mealName;
  final String mealType;
  final String mealNote;
  final List<Food> foods;
  final String imageUrl;
  final String id;

  Meal({
    required this.mealMacros,
    required this.mealName,
    required this.mealType,
    required this.mealNote,
    required this.foods,
    required this.imageUrl,
    required this.id,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealMacros: MealMacros.fromJson(json['mealmacros'] ?? {}),
      mealName: json['mealname'] ?? '',
      mealType: json['mealtype'] ?? '',
      mealNote: json['mealnote'] ?? '',
      foods: json['foods'] != null
          ? List<Food>.from(json['foods'].map((food) => Food.fromJson(food)))
          : [],
      imageUrl: json['imageUrl'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class MealMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  MealMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory MealMacros.fromJson(Map<String, dynamic> json) {
    return MealMacros(
      calories: (json['calories'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
    );
  }
}

class Food {
  final Macros macros;
  final bool consumed;
  final String food;
  final int amount;
  final String foodName;
  final String foodImage;
  final String servingUnit;
  final String id;

  Food({
    required this.macros,
    required this.consumed,
    required this.food,
    required this.amount,
    required this.foodName,
    required this.foodImage,
    required this.servingUnit,
    required this.id,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      macros: Macros.fromJson(json['macros'] ?? {}),
      consumed: json['consumed'] ?? false,
      food: json['food'] ?? '',
      amount: json['amount'] ?? 0,
      foodName: json['foodname'] ?? '',
      foodImage: json['foodImage'] ?? '',
      servingUnit: json['servingUnit'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class Macros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  Macros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory Macros.fromJson(Map<String, dynamic> json) {
    return Macros(
      calories: (json['calories'] ?? 0).toDouble(),
      proteins: (json['proteins'] ?? 0).toDouble(),
      fats: (json['fats'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
    );
  }
}
