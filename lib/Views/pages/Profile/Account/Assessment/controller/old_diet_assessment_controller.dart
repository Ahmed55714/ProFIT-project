import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';
import '../model/old_diet_assessment.dart';

class OldAssessmentController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  final Rx<OldDietAssessment?> oldDietAssessment = Rx<OldDietAssessment?>(null);

  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bodyFatController = TextEditingController();
  final TextEditingController waistAreaController = TextEditingController();
  final TextEditingController neckAreaController = TextEditingController();
  final TextEditingController numberOfMealsController = TextEditingController();
  final TextEditingController dietTypeController = TextEditingController();
  final TextEditingController foodAllergensController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  final TextEditingController updatedAtController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();
  final TextEditingController goalController = TextEditingController();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onReady() {
    super.onReady();
    fetchOldDietAssessment();
  }

  void fetchOldDietAssessment() async {
    isLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage('Authentication token not found');
        isLoading(false);
        return;
      }

      var response = await apiService.fetchOldDietAssessment(token);
      if (response != null) {
        oldDietAssessment.value = response;
        genderController.text = response.gender;
        birthDateController.text = formatDate(response.birthDate);
        heightController.text = response.height.toString();
        weightController.text = response.weight.toString();
        bodyFatController.text = response.bodyFat.toString();
        waistAreaController.text = response.waistArea.toString();
        neckAreaController.text = response.neckArea.toString();
        numberOfMealsController.text = response.numberOfMeals.toString();
        dietTypeController.text = response.dietType;
        foodAllergensController.text = response.foodAllergens.join(', ');
        diseaseController.text = response.disease.join(', ');
        statusController.text = response.status;
        createdAtController.text = formatDate(response.createdAt);
        updatedAtController.text = formatDate(response.updatedAt);
        activityLevelController.text = response.activityLevel;
        goalController.text = response.fitnessGoals;
        update();
      } else {
        errorMessage('Failed to fetch old diet assessment data');
      }
    } catch (e) {
      errorMessage('Failed to fetch old diet assessment data: $e');
    } finally {
      isLoading(false);
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
