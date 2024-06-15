import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/nutration.dart';

class NutritionPlanController extends GetxController {
  var nutritionPlans = <NutritionPlan>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchNutritionPlans();
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
        Get.snackbar('Error', 'Authentication token not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch nutrition plans: $e');
      print('Error fetching nutrition plans: $e');
    }
  }
}
