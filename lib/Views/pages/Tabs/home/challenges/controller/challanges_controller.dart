import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../services/api_service.dart';
import '../model/challanges.dart';

class ChallengeController extends GetxController {
  final ApiService _challengeService = ApiService();
  var isLoading = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;
  var challenges = <Challenge>[].obs;

  Future<void> addChallenge(String title, File image) async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      bool isSuccess = await _challengeService.addChallenge(token, title, image);
      if (isSuccess) {
        successMessage.value = 'Challenge added successfully';
        await fetchChallenges();
      } else {
        errorMessage.value = 'Failed to add challenge';
      }
    } else {
      errorMessage.value = 'Authorization token not found';
    }

    isLoading.value = false;
  }

  Future<void> fetchChallenges() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      try {
        
        List<Challenge> fetchedChallenges = await _challengeService.fetchChallenges(token);
        challenges.value = fetchedChallenges;
      } catch (e) {
        errorMessage.value = 'Failed to fetch challenges';
      }
    } else {
      errorMessage.value = 'Authorization token not found';
    }

    isLoading.value = false;
  }



   Future<void> giveUpChallenge(String challengeId) async {
    isLoading.value = true;

    bool isSuccess = await _challengeService.giveUpChallenge(challengeId);
    if (isSuccess) {
      successMessage.value = 'Challenge given up successfully';
      fetchChallenges();
    } else {
      errorMessage.value = 'Failed to give up challenge';
    }

    isLoading.value = false;
  }
   Future<void> deleteChallenge(String challengeId) async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      try {
        bool isSuccess = await _challengeService.deleteChallenge(challengeId);
        if (isSuccess) {
          successMessage.value = 'Challenge deleted successfully';
          fetchChallenges();
        } else {
          errorMessage.value = 'Failed to delete challenge';
        }
      } catch (e) {
        errorMessage.value = 'Failed to delete challenge: $e';
      }
    } else {
      errorMessage.value = 'Authorization token not found';
    }

    isLoading.value = false;
  }
}