import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/trainer.dart';

class ExploreController extends GetxController {
  var trainers = <Trainer>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    _loadTrainers();
  }

void _loadTrainers() async {
    try {
        final token = await apiService.getToken();
        if (token != null) {
            var fetchedTrainers = await apiService.fetchAllTrainers(token);
            if (fetchedTrainers.isNotEmpty) {
                trainers.assignAll(fetchedTrainers);
                print('Trainers loaded: ${trainers.length}');
            } else {
                print("No trainers fetched from API.");
            }
        } else {
            Get.snackbar('Error', 'Authentication token not found');
        }
    } catch (e) {
        Get.snackbar('Error', 'Failed to fetch trainers: $e');
        print('Error fetching trainers: $e');
    }
}

}
