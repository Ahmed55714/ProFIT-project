

import '../../Diet Plan Overview/model/diet_over_plan.dart';

class SSPlanMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  SSPlanMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory SSPlanMacros.fromJson(Map<String, dynamic> json) {
    return SSPlanMacros(
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}

class SSEatenDaysMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  SSEatenDaysMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory SSEatenDaysMacros.fromJson(Map<String, dynamic> json) {
    return SSEatenDaysMacros(
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}

class SSDayMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  SSDayMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory SSDayMacros.fromJson(Map<String, dynamic> json) {
    return SSDayMacros(
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}

class SSMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  SSMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory SSMacros.fromJson(Map<String, dynamic> json) {
    return SSMacros(
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}

class SSFood {
  final SSMacros macros;
  final bool consumed;
  final String food;
  final int amount;
  final String foodName;
  final String foodImage;
  final String servingUnit;
  final String id;

  SSFood({
    required this.macros,
    required this.consumed,
    required this.food,
    required this.amount,
    required this.foodName,
    required this.foodImage,
    required this.servingUnit,
    required this.id,
  });

  factory SSFood.fromJson(Map<String, dynamic> json) {
    return SSFood(
      macros: SSMacros.fromJson(json['macros']),
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

class SSMealMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  SSMealMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory SSMealMacros.fromJson(Map<String, dynamic> json) {
    return SSMealMacros(
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}
Meal convertSSMealToMeal(SSMeal ssMeal) {
  return Meal(
    mealMacros: MealMacros(
      calories: ssMeal.mealMacros.calories,
      proteins: ssMeal.mealMacros.proteins,
      fats: ssMeal.mealMacros.fats,
      carbs: ssMeal.mealMacros.carbs,
    ),
    mealName: ssMeal.mealName,
    mealType: ssMeal.mealType,
    mealNote: ssMeal.mealNote,
    foods: ssMeal.foods.map((ssFood) => Food(
      macros: Macros(
        calories: ssFood.macros.calories,
        proteins: ssFood.macros.proteins,
        fats: ssFood.macros.fats,
        carbs: ssFood.macros.carbs,
      ),
      consumed: ssFood.consumed,
      food: ssFood.food,
      amount: ssFood.amount,
      foodName: ssFood.foodName,
      foodImage: ssFood.foodImage,
      servingUnit: ssFood.servingUnit,
      id: ssFood.id,
    )).toList(),
    imageUrl: ssMeal.imageUrl,
    id: ssMeal.id,
  );
}

class SSMeal {
  final SSMealMacros mealMacros;
  final String mealName;
  final String mealType;
  final String mealNote;
  final List<SSFood> foods;
  final String imageUrl;
  final String id;

  SSMeal({
    required this.mealMacros,
    required this.mealName,
    required this.mealType,
    required this.mealNote,
    required this.foods,
    required this.imageUrl,
    required this.id,
  });

  factory SSMeal.fromJson(Map<String, dynamic> json) {
    return SSMeal(
      mealMacros: SSMealMacros.fromJson(json['mealmacros']),
      mealName: json['mealname'] ?? '',
      mealType: json['mealtype'] ?? '',
      mealNote: json['mealnote'] ?? '',
      foods: json['foods'] != null
          ? List<SSFood>.from(json['foods'].map((food) => SSFood.fromJson(food)))
          : [],
      imageUrl: json['imageUrl'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class SSDay {
  final SSDayMacros dayMacros;
  final SSEatenDaysMacros eatenDaysMacros;
  final DateTime startDate;
  final String day;
  final List<SSMeal> meals;
  final int mealsCount;
  final String id;

  SSDay({
    required this.dayMacros,
    required this.eatenDaysMacros,
    required this.startDate,
    required this.day,
    required this.meals,
    required this.mealsCount,
    required this.id,
  });

  factory SSDay.fromJson(Map<String, dynamic> json) {
    return SSDay(
      dayMacros: SSDayMacros.fromJson(json['daymacros']),
      eatenDaysMacros: SSEatenDaysMacros.fromJson(json['eatenDaysMacros']),
      startDate: DateTime.parse(json['startDate']),
      day: json['day'] ?? '',
      meals: json['meals'] != null
          ? List<SSMeal>.from(json['meals'].map((meal) => SSMeal.fromJson(meal)))
          : [],
      mealsCount: json['mealsCount'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}

class SSDietPlanActive {
  late final SSPlanMacros planMacros;
  late final SSEatenDaysMacros eatenDaysMacros;
  final String id;
  final String trainer;
  final String trainee;
  final int daysCount;
  final DateTime startDate;
  final List<SSDay> days;
  final String planType;
  final bool published;
  final String status;
  final String originalPlan;

  SSDietPlanActive({
    required this.planMacros,
    required this.eatenDaysMacros,
    required this.id,
    required this.trainer,
    required this.trainee,
    required this.daysCount,
    required this.startDate,
    required this.days,
    required this.planType,
    required this.published,
    required this.status,
    required this.originalPlan,
  });

  factory SSDietPlanActive.fromJson(Map<String, dynamic> json) {
    return SSDietPlanActive(
      planMacros: SSPlanMacros.fromJson(json['planmacros']),
      eatenDaysMacros: json['eatenDaysMacros'] != null
          ? SSEatenDaysMacros.fromJson(json['eatenDaysMacros'])
          : SSEatenDaysMacros(calories: 0, proteins: 0, fats: 0, carbs: 0),
      id: json['_id'],
      trainer: json['trainer'],
      trainee: json['trainee'],
      daysCount: json['daysCount'],
      startDate: DateTime.parse(json['startDate']),
      days: (json['days'] as List).map((i) => SSDay.fromJson(i)).toList(),
      planType: json['plantype'],
      published: json['published'],
      status: json['status'],
      originalPlan: json['originalPlan'],
    );
  }
}