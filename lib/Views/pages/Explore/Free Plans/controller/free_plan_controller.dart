import 'package:get/get.dart';
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
      var plans = await apiService.fetchFreeDietPlans(token, trainerId);
      dietPlans.assignAll(plans);
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
}
