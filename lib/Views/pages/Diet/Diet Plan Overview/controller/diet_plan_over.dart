import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/diet_over_plan.dart';


class PlanOverviewController extends GetxController {
  var selectedPlanDetails = Rx<DietPlanOverviewModel?>(null);
  var breakfastMeals = <Meal>[].obs;
  var lunchMeals = <Meal>[].obs;
  var snackMeals = <Meal>[].obs;
  var dinnerMeals = <Meal>[].obs;
  final ApiService apiService = ApiService();

  Future<void> fetchNutritionPlanDetails(String planId) async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedPlanDetails = await apiService.fetchNutritionPlanDetails(token, planId);

        selectedPlanDetails.value = DietPlanOverviewModel.fromJson(fetchedPlanDetails['data']);
        if (selectedPlanDetails.value != null) {
          var dayDetails = selectedPlanDetails.value!.days.firstWhere((day) => day.day == "1");
          breakfastMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Breakfast").toList());
          lunchMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Lunch").toList());
          snackMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Snack").toList());
          dinnerMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Dinner").toList());
        }
      } else {
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
