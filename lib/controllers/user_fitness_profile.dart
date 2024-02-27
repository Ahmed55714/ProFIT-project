import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_fitness_profile.dart';
import '../services/api_service.dart';

class StepProgressController extends GetxController {
  var currentStep = 1.obs;
  var totalSteps = 6;

  String gender = '';
  String birthDate = '';
  double weight = 0;
  int height = 0;
  String fitnessGoals = '';
  String activityLevel = '';

  void setHeight(int newHeight) {
    height = newHeight;
    update();
  }

  void setWeight(double newWeight) {
    weight = newWeight;
    update();
  }

  final ApiService apiService = ApiService();

  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void setGender(String newGender) {
    gender = newGender;
    update();
  }

  void setBirthDate(DateTime newBirthDate) {
    // Format the date to "yyyy-MM-dd"
    String formattedDate = DateFormat('yyyy-MM-dd').format(newBirthDate);
    birthDate = formattedDate;
    update();
  }

  void setFitnessGoals(String newFitnessGoal) {
    fitnessGoals = newFitnessGoal;
    update();
  }

  void setActivityLevel(String newActivityLevel) {
    activityLevel = newActivityLevel;
    update();
  }

  Map<String, dynamic> collectData() {
    return {
      'gender': gender,
      'birthDate': birthDate,
      'weight': weight.round(),
      'height': height,
      'fitnessGoals': fitnessGoals,
      'activityLevel': activityLevel,
    };
  }

  Future<void> submitFitnessProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token != null) {
      var profileData = collectData();
      bool success =
          await apiService.postUserFitnessProfile(profileData, token);
      if (success) {
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update profile');
        print('Failed to update profile${profileData.toString()}');
        print('Failed to update profile${token.toString()}');
      }
    } else {
      Get.snackbar('Error', 'Authentication token not found');
    }
  }
}
