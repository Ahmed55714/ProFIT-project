import 'package:get/get.dart';

import '../../../../../services/api_service.dart';
import '../model/subscription_details.dart';

class CheckoutController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  var isLoading = false.obs; 
  var subscriptionDetails = SubscriptionDetails(
    trainerName: '',
    profilePhoto: '',
    subscriptionType: '',
    duration: '',
    startDate: '',
    endDate: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionDetails();
  }



void fetchSubscriptionDetails() async {
  try {
    isLoading(true);
    
    var details = await apiService.fetchSubscriptionDetails();
    subscriptionDetails.value = details;
    isLoading(false);
  } catch (e) {
    print('Error fetching subscription details: $e');
    isLoading(false);
  }
}


Future<void> submitPayment(String packageId) async {
    isLoading(true);
    try {
      var response = await apiService.subscribeToPackage(packageId);
      if (response['success']) {
        Get.snackbar('Success', response['message'] ?? 'Subscription successful!');
      } else {
        Get.snackbar('Error', 'Subscription failed: ${response['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
