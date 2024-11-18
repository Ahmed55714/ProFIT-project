import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../services/api_service.dart';
import '../model/list_old_assessment.dart';

class OldDietAssessmentController extends GetxController {
  var oldDietAssessments = <OldDietAssessment>[].obs;
  var isLoading = true.obs;
  final ApiService apiService;

  OldDietAssessmentController(this.apiService);

  @override
  void onInit() {
    fetchOldDietAssessments();
    super.onInit();
  }

  void fetchOldDietAssessments() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        var assessments = await apiService.fetchOldDietAssessments(token);
        oldDietAssessments.assignAll(assessments);
      }
    } finally {
      isLoading(false);
    }
  }
}
