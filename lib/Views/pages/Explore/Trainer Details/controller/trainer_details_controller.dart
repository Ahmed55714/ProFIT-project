import 'package:get/get.dart';
import 'package:profit1/Views/pages/Explore/Trainer%20Details/model/trainer_details.dart';

import '../../../../../services/api_service.dart';
import '../trainer_details.dart';

class TrainerDetailsController extends GetxController {
  var isLoading = true.obs;
  var trainerDetails = TrainerAbout().obs;

  final ApiService apiService = ApiService();

  void loadTrainerDetails(String trainerId) async {
    try {
      isLoading(true);
      final token = await apiService.getToken(); // Fetch the auth token
      trainerDetails.value = (await apiService.fetchTrainerAbout(trainerId, token))!;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trainer details: $e');
    } finally {
      isLoading(false);
    }
  }
}
