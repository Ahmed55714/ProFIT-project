import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/subscription_details.dart';
import '../../../../../services/api_service.dart';

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
    price: 0,
    //trainerId: '', // Initialize this field
  ).obs;
  var isSubscriptionCancelled = false.obs;

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
    } catch (e) {
      print('Error fetching subscription details: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelSubscription() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found');
        return;
      }

      final response = await http.post(
        Uri.parse('https://profit-qjbo.onrender.com/api/v1/trainees/subscription/cancelSubscription/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success']) {
        Get.snackbar('Success', responseBody['message']);
        isSubscriptionCancelled(true);
        fetchSubscriptionDetails();
      } else {
        Get.snackbar('Error', responseBody['message'] ?? 'Failed to cancel subscription');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> submitPayment(String packageId) async {
    isLoading(true);
    try {
      var response = await apiService.subscribeToPackage(packageId);
      if (response['success']) {
        Get.snackbar('Success', response['message'] ?? 'Subscription successful!');
        return true;
      } else {
        Get.snackbar('Error', 'Subscription failed: ${response['message']}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitReview(String trainerId, int rating, String comment) async {
    try {
      isLoading(true);
      final response = await apiService.submitReview(trainerId, rating, comment);
      if (response['success']) {
        Get.snackbar('Success', 'Review submitted successfully!');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to submit review');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }
}
