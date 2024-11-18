import '../../../../../services/api_service.dart';
import '../model/graphSteps.dart';


import 'package:get/get.dart';


class StepsControllergraph extends GetxController {
  var weeklySteps = <WeeklySteps>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchWeeklySteps();
    super.onInit();
  }

  Future<void> fetchWeeklySteps() async {
    try {
      isLoading(true);
      var steps = await ApiService().fetchWeeklySteps();
      if (steps != null) {
        weeklySteps.value = steps;
      }
    } finally {
      isLoading(false);
    }
  }
}
