import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profit1/services/api_service.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/model/diet_assessment.dart';
import '../model/old_diet_assessment.dart';

class DietAssessmentController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  var isLoading = true.obs;
  var oldDietAssessment = Rxn<OldDietAssessmentInformation>();
  var errorMessage = ''.obs;

  var genders = <String>[].obs; 
  var fitnessGoals = <String>[].obs;
  var activityLevels = <String>[].obs;
  var foodAllergens = <String>[].obs;
  var diseases = <String>[].obs;
  var religionRestrictions = <String>[].obs;
  var dietTypes = <String>[].obs;
  var numberOfMeals = <String>[].obs;

  TextEditingController goalController = TextEditingController();
  TextEditingController activityLevelController = TextEditingController();
  TextEditingController numberOfMealsController = TextEditingController();
  TextEditingController dietTypeController = TextEditingController();
  TextEditingController foodAllergensController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyFatController = TextEditingController();
  TextEditingController waistAreaController = TextEditingController();
  TextEditingController neckAreaController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadDietAssessment();
  }

  void loadDietAssessment() async {
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage('Authentication token not found');
        isLoading(false);
        return;
      }

      var data = await apiService.fetchDietAssessmentsData();

      if (data != null) {
        genders.value = List<String>.from(data['gender']); 
        fitnessGoals.value = List<String>.from(data['fitnessGoals']);
        activityLevels.value = List<String>.from(data['activityLevel']);
        foodAllergens.value = List<String>.from(data['foodAllergens']);
        diseases.value = List<String>.from(data['disease']);
        religionRestrictions.value = List<String>.from(data['religionRestriction']);
        dietTypes.value = List<String>.from(data['dietType']);
        numberOfMeals.value = List<String>.from(data['numberofmeals'].map((e) => e.toString()));
      } else {
        errorMessage('Failed to fetch diet assessment data');
      }
    } catch (e) {
      errorMessage('Failed to fetch diet assessments data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitDietAssessment(Map<String, dynamic> assessmentData) async {
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage('Authentication token not found');
        isLoading(false);
        return;
      }

      await apiService.submitDietAssessment(assessmentData);
      Get.snackbar('Success', 'Diet assessment submitted successfully');
    } catch (e) {
      errorMessage('Failed to submit diet assessment: $e');
    } finally {
      isLoading(false);
    }
  }

  Map<String, dynamic> getData() {
    List<String> foodAllergens = foodAllergensController.text.split(' . ');
    List<String> diseases = diseaseController.text.split(' . ');

    return {
      'goal': goalController.text,
      'activityLevel': activityLevelController.text,
      'numberOfMeals': int.tryParse(numberOfMealsController.text),
      'dietType': dietTypeController.text,
      'foodAllergens': foodAllergens,
      'disease': diseases,
      'weight': double.tryParse(weightController.text),
      'bodyFat': double.tryParse(bodyFatController.text),
      'waistArea': double.tryParse(waistAreaController.text),
      'neckArea': double.tryParse(neckAreaController.text),
    };
  }
}
