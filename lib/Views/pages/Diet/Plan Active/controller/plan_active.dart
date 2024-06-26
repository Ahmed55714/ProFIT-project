import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../../../Tabs/Diet/model/free_palns.dart';
import '../../Diet Plan Overview/model/diet_over_plan.dart';
import '../model/plan_active.dart';

class DietPlanActiveController extends GetxController {
  var isLoading = false.obs;
  var activePlanDetails = Rxn<DietPlanActive>();
  var breakfastMeals = <Meal>[].obs;
  var lunchMeals = <Meal>[].obs;
  var snackMeals = <Meal>[].obs;
  var dinnerMeals = <Meal>[].obs;
  final ApiService _apiService = ApiService();

  var _isDataFetched = false;
  var _isBreakfastFetched = false;
  var _isLunchFetched = false;
  var _isSnackFetched = false;
  var _isDinnerFetched = false;

  Future<void> fetchActivePlanDetails(String planId) async {
    if (_isDataFetched) {
      return; // If data is already fetched, do not fetch again
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

  void _populateMeals(DietPlanActive dietPlan) {
    var dayDetails = dietPlan.days.firstWhere((day) => day.day == "1");

    if (!_isBreakfastFetched) {
      breakfastMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Breakfast").toList());
      _isBreakfastFetched = true;
    }

    if (!_isLunchFetched) {
      lunchMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Lunch").toList());
      _isLunchFetched = true;
    }

    if (!_isSnackFetched) {
      snackMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Snack").toList());
      _isSnackFetched = true;
    }

    if (!_isDinnerFetched) {
      dinnerMeals.assignAll(dayDetails.meals.where((meal) => meal.mealType == "Dinner").toList());
      _isDinnerFetched = true;
    }
  }

  Future<void> refreshActivePlanDetails(String planId) async {
    _isDataFetched = false;
    _isBreakfastFetched = false;
    _isLunchFetched = false;
    _isSnackFetched = false;
    _isDinnerFetched = false;
    await fetchActivePlanDetails(planId);
  }

  void updateMacros(Map<String, dynamic> newMacros) {
    if (activePlanDetails.value != null) {
      activePlanDetails.value!.planMacros = PlanMacros.fromJson(newMacros);
      activePlanDetails.refresh();  // This will notify the listeners to rebuild the UI
    }
  }

  int getDayIndexForMeal(Meal meal) {
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
