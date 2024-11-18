import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/plan_active.dart';

class DietPlanActiveController extends GetxController {
  var isLoading = false.obs;
  var activePlanDetails = Rxn<SSDietPlanActive>();
  var breakfastMeals = <SSMeal>[].obs;
  var lunchMeals = <SSMeal>[].obs;
  var snackMeals = <SSMeal>[].obs;
  var dinnerMeals = <SSMeal>[].obs;
  final ApiService _apiService = ApiService();

  var _isDataFetched = false;

  Future<void> fetchActivePlanDetails(String planId) async {
    if (_isDataFetched) {
      return; // If data is already fetched, do not fetch again
    }

    isLoading(true);
    try {
      final token = await _apiService.getToken();
      if (token != null) {
        final response = await _apiService.getDietPlanDetails(planId, token);
        if (response != null && response['data'] != null && response['data'].isNotEmpty) {
          final dietPlan = SSDietPlanActive.fromJson(response['data'][0]);
          activePlanDetails.value = dietPlan;
          if (dietPlan != null) {
            _populateMeals(dietPlan);
          }
          _isDataFetched = true;
        }
      } else {
        print("Token not found or is empty");
      }
    } catch (e) {
      print('Error fetching active plan details: $e');
    } finally {
      isLoading(false);
    }
  }

  void _populateMeals(SSDietPlanActive dietPlan) {
    var dayDetails = dietPlan.days.firstWhere(
      (day) => day.day == "1",
      orElse: () => SSDay(
        dayMacros: SSDayMacros(calories: 0, proteins: 0, fats: 0, carbs: 0),
        eatenDaysMacros: SSEatenDaysMacros(calories: 0, proteins: 0, fats: 0, carbs: 0),
        startDate: DateTime.now(),
        day: '',
        meals: [],
        mealsCount: 0,
        id: '',
      ),
    );

    breakfastMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Breakfast").toList());
    lunchMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Lunch").toList());
    snackMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Snack").toList());
    dinnerMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Dinner").toList());
  }

  Future<void> refreshActivePlanDetails(String planId) async {
    _isDataFetched = false;
    await fetchActivePlanDetails(planId);
  }

  void updateMacros(Map<String, dynamic> newMacros) {
    if (activePlanDetails.value != null) {
      activePlanDetails.value!.planMacros = SSPlanMacros.fromJson(newMacros);
      activePlanDetails.refresh();  // This will notify the listeners to rebuild the UI
    }
  }

  int getDayIndexForMeal(SSMeal meal) {
    if (activePlanDetails.value != null) {
      for (int i = 0; i < activePlanDetails.value!.days.length; i++) {
        if (activePlanDetails.value!.days[i].meals.contains(meal)) {
          return i;
        }
      }
    }
    return -1; 
  }
}
