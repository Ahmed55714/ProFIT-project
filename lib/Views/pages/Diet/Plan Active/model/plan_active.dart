import '../../../Tabs/Diet/model/free_palns.dart';
import '../../Diet Plan Overview/model/diet_over_plan.dart';

class DietPlanActive {
  late final PlanMacros planMacros;
  late final EatenDaysMacros eatenDaysMacros;
  final String id;
  final String trainer;
  final String trainee;
  final int daysCount;
  final DateTime startDate;
  final List<Day> days;
  final String planType;
  final bool published;
  final String status;
  final String originalPlan;

  DietPlanActive({
    required this.planMacros,
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

  factory DietPlanActive.fromJson(Map<String, dynamic> json) {
    return DietPlanActive(
      planMacros: PlanMacros.fromJson(json['planmacros']),
      id: json['_id'],
      trainer: json['trainer'],
      trainee: json['trainee'],
      daysCount: json['daysCount'],
      startDate: DateTime.parse(json['startDate']),
      days: (json['days'] as List).map((i) => Day.fromJson(i)).toList(),
      planType: json['plantype'],
      published: json['published'],
      status: json['status'],
      originalPlan: json['originalPlan'],
    );
  }
}

// class PlanMacros {
//   final double calories;
//   final double proteins;
//   final double fats;
//   final double carbs;

//   PlanMacros({
//     required this.calories,
//     required this.proteins,
//     required this.fats,
//     required this.carbs,
//   });

//   factory PlanMacros.fromJson(Map<String, dynamic> json) {
//     return PlanMacros(
//       calories: (json['calories'] as num).toDouble(),
//       proteins: (json['proteins'] as num).toDouble(),
//       fats: (json['fats'] as num).toDouble(),
//       carbs: (json['carbs'] as num).toDouble(),
//     );
//   }
// }

// class Day {
//   final DayMacros dayMacros;
//   final EatenDaysMacros eatenDaysMacros;
//   final DateTime startDate;
//   final String day;
//   final List<Meal> meals;
//   final int mealsCount;
//   final String id;

//   Day({
//     required this.dayMacros,
//     required this.eatenDaysMacros,
//     required this.startDate,
//     required this.day,
//     required this.meals,
//     required this.mealsCount,
//     required this.id,
//   });

//   factory Day.fromJson(Map<String, dynamic> json) {
//     return Day(
//       dayMacros: DayMacros.fromJson(json['daymacros']),
//       eatenDaysMacros: EatenDaysMacros.fromJson(json['eatenDaysMacros']),
//       startDate: DateTime.parse(json['startDate']),
//       day: json['day'],
//       meals: (json['meals'] as List).map((i) => Meal.fromJson(i)).toList(),
//       mealsCount: json['mealsCount'],
//       id: json['_id'],
//     );
//   }
// }

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
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
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
      calories: (json['calories'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }
}









// class Meal {
//   final MealMacros mealMacros;
//   final String mealName;
//   final String mealType;
//   final String mealNote;
//   final List<Food> foods;
//   final String imageUrl;
//   final String id;

//   Meal({
//     required this.mealMacros,
//     required this.mealName,
//     required this.mealType,
//     required this.mealNote,
//     required this.foods,
//     required this.imageUrl,
//     required this.id,
//   });

//   factory Meal.fromJson(Map<String, dynamic> json) {
//     return Meal(
//       mealMacros: MealMacros.fromJson(json['mealmacros']),
//       mealName: json['mealname'] ?? '',
//       mealType: json['mealtype'] ?? '',
//       mealNote: json['mealnote'] ?? '',
//       foods: json['foods'] != null
//           ? List<Food>.from(json['foods'].map((food) => Food.fromJson(food)))
//           : [],
//       imageUrl: json['imageUrl'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }
// }

// class MealMacros {
//   final double calories;
//   final double proteins;
//   final double fats;
//   final double carbs;

//   MealMacros({
//     required this.calories,
//     required this.proteins,
//     required this.fats,
//     required this.carbs,
//   });

//   factory MealMacros.fromJson(Map<String, dynamic> json) {
//     return MealMacros(
//       calories: (json['calories'] ?? 0).toDouble(),
//       proteins: (json['proteins'] ?? 0).toDouble(),
//       fats: (json['fats'] ?? 0).toDouble(),
//       carbs: (json['carbs'] ?? 0).toDouble(),
//     );
//   }
// }

// class Food {
//   final Macros macros;
//   final bool consumed;
//   final String food;
//   final int amount;
//   final String foodName;
//   final String foodImage;
//   final String servingUnit;
//   final String id;

//   Food({
//     required this.macros,
//     required this.consumed,
//     required this.food,
//     required this.amount,
//     required this.foodName,
//     required this.foodImage,
//     required this.servingUnit,
//     required this.id,
//   });

//   factory Food.fromJson(Map<String, dynamic> json) {
//     return Food(
//       macros: Macros.fromJson(json['macros']),
//       consumed: json['consumed'] ?? false,
//       food: json['food'] ?? '',
//       amount: json['amount'] ?? 0,
//       foodName: json['foodname'] ?? '',
//       foodImage: json['foodImage'] ?? '',
//       servingUnit: json['servingUnit'] ?? '',
//       id: json['_id'] ?? '',
//     );
//   }
// }

// class Macros {
//   final double calories;
//   final double proteins;
//   final double fats;
//   final double carbs;

//   Macros({
//     required this.calories,
//     required this.proteins,
//     required this.fats,
//     required this.carbs,
//   });

//   factory Macros.fromJson(Map<String, dynamic> json) {
//     return Macros(
//       calories: (json['calories'] ?? 0).toDouble(),
//       proteins: (json['proteins'] ?? 0).toDouble(),
//       fats: (json['fats'] ?? 0).toDouble(),
//       carbs: (json['carbs'] ?? 0).toDouble(),
//     );
//   }
// }
