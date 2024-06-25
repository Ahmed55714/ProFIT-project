class HelloFreePlans {
  final bool success;
  final DailyMacros dailyMacros;
  final List<FreePlan> freePlans;

  HelloFreePlans({
    required this.success,
    required this.dailyMacros,
    required this.freePlans,
  });

  factory HelloFreePlans.fromJson(Map<String, dynamic> json) {
    return HelloFreePlans(
      success: json['success'] ?? false,
      dailyMacros: DailyMacros.fromJson(json['dailyMacros']),
      freePlans: (json['Freeplans'] as List<dynamic>?)
              ?.map((e) => FreePlan.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'dailyMacros': dailyMacros.toJson(),
      'Freeplans': freePlans.map((e) => e.toJson()).toList(),
    };
  }

  HelloFreePlans copyWith({
    bool? success,
    DailyMacros? dailyMacros,
    List<FreePlan>? freePlans,
  }) {
    return HelloFreePlans(
      success: success ?? this.success,
      dailyMacros: dailyMacros ?? this.dailyMacros,
      freePlans: freePlans ?? this.freePlans,
    );
  }
}

class DailyMacros {
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;

  DailyMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory DailyMacros.fromJson(Map<String, dynamic> json) {
    return DailyMacros(
      calories: json['calories'] ?? 0,
      proteins: json['proteins'] ?? 0,
      fats: json['fats'] ?? 0,
      carbs: json['carbs'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbs': carbs,
    };
  }
}

class FreePlan {
  final PlanMacros planMacros;
  final String id;
  final String planName;
  final TrainerFreePlan trainer;
  final int daysCount;
  final String dietType;
  final String description;

  FreePlan({
    required this.planMacros,
    required this.id,
    required this.planName,
    required this.trainer,
    required this.daysCount,
    required this.dietType,
    required this.description,
  });

  factory FreePlan.fromJson(Map<String, dynamic> json) {
    return FreePlan(
      planMacros: PlanMacros.fromJson(json['planmacros']),
      id: json['_id'] ?? '',
      planName: json['planName'] ?? '',
      trainer: TrainerFreePlan.fromJson(json['trainer']),
      daysCount: json['daysCount'] ?? 0,
      dietType: json['dietType'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planmacros': planMacros.toJson(),
      '_id': id,
      'planName': planName,
      'trainer': trainer.toJson(),
      'daysCount': daysCount,
      'dietType': dietType,
      'description': description,
    };
  }
}

class PlanMacros {
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;

  PlanMacros({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
  });

  factory PlanMacros.fromJson(Map<String, dynamic> json) {
    return PlanMacros(
      calories: (json['calories'] ?? 0.0).toDouble(),
      proteins: (json['proteins'] ?? 0.0).toDouble(),
      fats: (json['fats'] ?? 0.0).toDouble(),
      carbs: (json['carbs'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbs': carbs,
    };
  }
}

class TrainerFreePlan {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePhoto;

  TrainerFreePlan({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  factory TrainerFreePlan.fromJson(Map<String, dynamic> json) {
    return TrainerFreePlan(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'profilePhoto': profilePhoto,
    };
  }
}
