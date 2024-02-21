import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';

class StepProgressController extends GetxController {
  var currentStep = 1.obs;
  var totalSteps = 6;

  String gender = '';
  String birthDate = '';
  int weight = 0;
  int height = 0;
  String fitnessGoals = '';
  String activityLevel = '';
  
  final ApiService apiService = ApiService(); // Initialize ApiService

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

  Map<String, dynamic> collectData() {
    return {
      'gender': gender,
      'birthDate': birthDate,
      'weight': weight,
      'height': height,
      'fitnessGoals': fitnessGoals,
      'activityLevel': activityLevel,
    };
  }

  Future<bool> submitData() async {
    final String submitUrl = "${apiService.baseUrl}/submitData"; // Adjust the endpoint as necessary
    try {
      final response = await http.post(
        Uri.parse(submitUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(collectData()),
      );
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }
}
