import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/transformation.dart';

class TransformController extends GetxController {
  final ApiService _apiService = ApiService();
  final Rx<TransformationDetails?> transformationDetails = Rx<TransformationDetails?>(null);

  @override
  void onInit() {
    super.onInit();

  }

  void fetchDetails(String trainerId) async {
    try {
      String? token = await _apiService.getToken();
      if (token != null) {
        var details = await _apiService.fetchTransformationDetails(trainerId);
        if (details != null) {
          transformationDetails.value = details;
          print("Details updated in controller.");
        } else {
          print("No details were fetched.");
        }
      } else {
        print("Token is null, authenticate first.");
      }
    } catch (e) {
      print('Error fetching transformation details: $e');
    }
  }
}
