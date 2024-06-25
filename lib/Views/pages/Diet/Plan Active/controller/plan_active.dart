import 'package:get/get.dart';


import '../../../../../services/api_service.dart';
import '../../Diet Plan Overview/model/diet_over_plan.dart';
import '../model/plan_active.dart'; 

import 'package:get/get.dart';

class DietPlanActiveController extends GetxController {
  var isLoading = false.obs;
  var activePlanDetails = Rxn<DietPlanActive>();
  var breakfastMeals = <Meal>[].obs;
  var lunchMeals = <Meal>[].obs;
  var snackMeals = <Meal>[].obs;
  var dinnerMeals = <Meal>[].obs;
  final ApiService _apiService = ApiService();
  var _isDataFetched = false;

  Future<void> fetchActivePlanDetails(String planId) async {
    if (_isDataFetched) {
      // If data is already fetched, do not fetch again
      return;
    }
    
    isLoading(true);
    try {
      final token = await _apiService.getToken();
      if (token != null) {
        final response = await _apiService.getDietPlanDetails(planId, token);
        if (response != null) {
                 

          final dietPlan = DietPlanActive.fromJson(response['data'][0]);
          activePlanDetails.value = dietPlan;
          if (dietPlan != null) {
            var dayDetails = dietPlan.days.firstWhere((day) => day.day == "1");
            breakfastMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Breakfast").toList());
            lunchMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Lunch").toList());
            snackMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Snack").toList());
            dinnerMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Dinner").toList());
          }
          _isDataFetched = true;
        }
      } else {
        // Handle token not found or empty case
        print("Token not found or is empty");
      }
    } catch (e) {
      print('Error fetching active plan details: $e');
    } finally {
      isLoading(false);
    }
  }
}
