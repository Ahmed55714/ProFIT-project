import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/plan_active.dart';

class ActivePlanController extends GetxController {
  var dietPlans = <DietPlanActive>[].obs;
  var selectedPlanDetails = DietPlanActive(
    id: '',
    planName: '',
    trainer: '',
    trainee: '',
    plantype: '',
    published: false,
    status: '',
    days: [],
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchDietPlans();
  }

  void fetchDietPlans() async {
    try {
      ApiService apiService = ApiService();
      String? token = await apiService.getToken();
      if (token != null && token.isNotEmpty) {
        var plans = await apiService.fetchDietPlans(token);
        if (plans.isNotEmpty) {
          dietPlans.value = plans;
          selectedPlanDetails.value = plans[0]; // Select the first plan for example
        }
      } else {
        // Handle token not found scenario
        print("Token not found or is empty");
      }
    } catch (e) {
      print(e);
    }
  }
}
