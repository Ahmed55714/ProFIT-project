import 'package:get/get.dart';
import '../../../../../../../services/api_service.dart';

import '../model/model.dart';

class MeasurementsController extends GetxController {
  final ApiService apiService;

  MeasurementsController(this.apiService);

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var measurements = MeasurementsData(weight: [], bodyFat: [], waistArea: [], neckArea: []).obs;

  @override
  void onInit() {
    fetchMeasurements();
    super.onInit();
  }

  void fetchMeasurements() async {
    try {
      isLoading(true);
      measurements.value = await apiService.fetchMeasurements();
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
