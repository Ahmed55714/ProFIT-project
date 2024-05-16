import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';
import '../model/diet_assessment.dart';

class DietAssessmentController extends GetxController {
  var isLoading = RxBool(true);
  Rx<DietAssessment?> dietAssessment = Rx<DietAssessment?>(null);

  void loadDietAssessment() async {
    final ApiService apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      var result = await apiService.fetchDietAssessment(token);
      dietAssessment.value = result;
    } else {
      print('Authentication token not found');
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    loadDietAssessment();
  }
}
