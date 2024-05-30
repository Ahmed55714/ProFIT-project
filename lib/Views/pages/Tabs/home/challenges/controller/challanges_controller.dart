import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';

class ChallengeController extends GetxController {
  final ApiService _challengeService = ApiService();
  var isLoading = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;

  Future<void> addChallenge(String title, File image) async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      bool isSuccess = await _challengeService.addChallenge(token, title, image);
      if (isSuccess) {
        successMessage.value = 'Challenge added successfully';
      } else {
        errorMessage.value = 'Failed to add challenge';
      }
    } else {
      errorMessage.value = 'Authorization token not found';
    }

    isLoading.value = false;
  }
}
