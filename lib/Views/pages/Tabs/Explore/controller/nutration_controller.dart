import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/nutration.dart';

class NutritionPlanController extends GetxController {
  var nutritionPlans = <NutritionPlan>[].obs;
  var favoriteNutritionPlans = <NutritionPlan>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchNutritionPlans();
    fetchFavoriteNutritionPlans();
  }

  Future<void> fetchNutritionPlans() async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedPlans = await apiService.fetchNutritionPlans(token);
        if (fetchedPlans.isNotEmpty) {
          nutritionPlans.assignAll(fetchedPlans);
          print('Nutrition Plans loaded: ${nutritionPlans.length}');
        } else {
          print("No nutrition plans fetched from API.");
        }
      } else {
      //  Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Failed to fetch nutrition plans: $e');
      print('Error fetching nutrition plans: $e');
    }
  }

  Future<void> fetchFavoriteNutritionPlans() async {
    try {
      final token = await apiService.getToken();
      if (token != null) {
        var fetchedPlans = await apiService.fetchFavoriteDiet(token);
        if (fetchedPlans.isNotEmpty) {
          favoriteNutritionPlans.assignAll(fetchedPlans);
          print('Favorite Nutrition Plans loaded: ${favoriteNutritionPlans.length}');
        } else {
          print("No favorite nutrition plans fetched from API.");
        }
      } else {
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch favorite nutrition plans: $e');
      print('Error fetching favorite nutrition plans: $e');
    }
  }

  void toggleFavoriteDiet(String planId) async {
    int index = nutritionPlans.indexWhere((plan) => plan.id == planId);
    if (index != -1) {
      String? token = await apiService.getToken();
      if (token != null) {
        try {
          var response = await apiService.toggleFavoriteDiet(planId, token);
          if (response['success']) {
            bool isFavorite = response['isFavorite'];
            nutritionPlans[index] = nutritionPlans[index].copyWith(isFavorite: isFavorite);
            if (isFavorite) {
              favoriteNutritionPlans.add(nutritionPlans[index]);
            } else {
              favoriteNutritionPlans.removeWhere((plan) => plan.id == planId);
            }
            nutritionPlans.refresh();
            favoriteNutritionPlans.refresh();
          } else {
            print('Error toggling favorite status: ${response['message']}');
          }
        } catch (e) {
          print('Error toggling favorite: $e');
        }
      }
    }
  }
}
