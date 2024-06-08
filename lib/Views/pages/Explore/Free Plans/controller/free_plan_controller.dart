import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/api_service.dart';
import '../model/free_plan.dart';

class DietPlanController extends GetxController {
  var dietPlans = <DietPlan>[].obs;
  var isLoading = true.obs;
  final ApiService apiService;
  late String trainerId;
  late String token;

  DietPlanController(this.apiService);

  void initialize(String trainerId, String token) {
    this.trainerId = trainerId;
    this.token = token;
    fetchDietPlans();
  }

  void fetchDietPlans() async {
    try {
      isLoading(true);
      print('Fetching diet plans for trainerId: $trainerId with token: $token');
      var plans = await apiService.fetchFreeDietPlans(token, trainerId);
      print('Fetched diet plans: $plans');
      dietPlans.assignAll(plans);
    } catch (e) {
      print('Error fetching diet plans: $e');
    } finally {
      isLoading(false);
    }
  }
}
