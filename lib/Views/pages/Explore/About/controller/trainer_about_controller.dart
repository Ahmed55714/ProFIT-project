import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/trainer_about.dart';

class TrainerDetailsController extends GetxController {
  var isLoading = RxBool(false);
  var trainerDetails = Rxn<TrainerAbout>();
  final ApiService apiService = Get.find<ApiService>();

  void loadTrainerDetails(String trainerId) async {
    isLoading(true);
    try {
      var details = await apiService.fetchTrainerAbout(trainerId);
      if (details != null) {
        trainerDetails.value = details; 
      } else {
        Get.snackbar('Info', 'No details available for this trainer');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch trainer details: $e');
    } finally {
      isLoading(false);
    }
  }
}
