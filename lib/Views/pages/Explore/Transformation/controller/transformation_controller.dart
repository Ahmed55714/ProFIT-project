import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../model/transformation.dart';

class TransformController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<TransformationDetails> transformations = RxList<TransformationDetails>();

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
          transformations.assignAll(details as Iterable<TransformationDetails>);
        } else {
        }
      } else {
      }
    } catch (e) {
    }
  }
}
