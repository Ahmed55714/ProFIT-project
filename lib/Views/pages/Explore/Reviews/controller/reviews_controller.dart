import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/reviews.dart';

class ReviewController extends GetxController {
  final ApiService apiService;
  final Rx<ReviewsData?> reviewsData = Rx<ReviewsData?>(null);

  ReviewController({required this.apiService});

  void fetchReviews(String trainerId) async {
    try {
      final data = await apiService.fetchTrainerReviews(trainerId);
      if (data != null) {
        reviewsData.value = data;
      } else {
      }
    } catch (e) {
    }
  }
}
