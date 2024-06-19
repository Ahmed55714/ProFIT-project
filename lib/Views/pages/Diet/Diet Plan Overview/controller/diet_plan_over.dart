import 'package:get/get.dart';
import 'package:profit1/Views/pages/Diet/Diet%20Plan%20Overview/model/diet_over_plan.dart';
import '../../../../../services/api_service.dart';

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
        print('Fetched Plan Details: $fetchedPlanDetails');

        selectedPlanDetails.value = DietPlanOverviewModel.fromJson(fetchedPlanDetails['data']);
        if (selectedPlanDetails.value != null) {
          var dayDetails = selectedPlanDetails.value!.days.firstWhere((day) => day.day == "1");
          breakfastMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Breakfast").toList());
          lunchMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Lunch").toList());
          snackMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Snack").toList());
          dinnerMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Dinner").toList());
        }
      } else {
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch nutrition plan details: $e');
      print('Error: $e');
    }
  }
}
