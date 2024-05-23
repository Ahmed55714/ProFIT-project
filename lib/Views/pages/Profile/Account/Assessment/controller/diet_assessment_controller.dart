// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:profit1/Views/pages/Profile/Account/Assessment/model/diet_assessment.dart';
// import '../../../../../../services/api_service.dart';

// class DietAssessmentController extends GetxController {
//   final ApiService apiService = Get.find<ApiService>();

//   var isLoading = RxBool(true);
//   var fitnessGoals = <String>[].obs;
//   var activityLevels = <String>[].obs;
//   var foodAllergens = <String>[].obs;
//   var diseases = <String>[].obs;
//   var religionRestrictions = <String>[].obs;
//   var dietTypes = <String>[].obs;
//   var numberOfMeals = <String>[].obs;
//   var errorMessage = ''.obs;

//   TextEditingController goalController = TextEditingController();
//   TextEditingController activityLevelController = TextEditingController();
//   TextEditingController numberOfMealsController = TextEditingController();
//   TextEditingController dietTypeController = TextEditingController();
//   TextEditingController foodAllergensController = TextEditingController();
//   TextEditingController diseaseController = TextEditingController();

//   @override
//   void onInit() {
//     super.onInit();
//     loadDietAssessment();
//   }

//   void loadDietAssessment() async {
//     isLoading(true);
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');

//       if (token == null) {
//         errorMessage('Authentication token not found');
//         isLoading(false);
//         return;
//       }

//       var data = await apiService.fetchDietAssessmentsData();

//       if (data != null) {
//         fitnessGoals.value = List<String>.from(data['fitnessGoals']);
//         activityLevels.value = List<String>.from(data['activityLevel']);
//         foodAllergens.value = List<String>.from(data['foodAllergens']);
//         diseases.value = List<String>.from(data['disease']);
//         religionRestrictions.value = List<String>.from(data['religionRestriction']);
//         dietTypes.value = List<String>.from(data['dietType']);
//         numberOfMeals.value = List<String>.from(data['numberofmeals'].map((e) => e.toString()));
//       } else {
//         errorMessage('Failed to fetch diet assessment data');
//       }
//     } catch (e) {
//       errorMessage('Failed to fetch diet assessments data: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> submitDietAssessment(Map<String, dynamic> assessmentData) async {
//     isLoading(true);
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');

//       if (token == null) {
//         errorMessage('Authentication token not found');
//         isLoading(false);
//         return;
//       }

//       await apiService.submitDietAssessment(assessmentData);
//       Get.snackbar('Success', 'Diet assessment submitted successfully');
//     } catch (e) {
//       errorMessage('Failed to submit diet assessment: $e');
//     } finally {
//       isLoading(false);
//     }
//   }

//   Map<String, dynamic> getData() {
//     return {
//       'goal': goalController.text,
//       'activityLevel': activityLevelController.text,
//       'numberOfMeals': int.tryParse(numberOfMealsController.text),
//       'dietType': dietTypeController.text,
//       'foodAllergens': foodAllergensController.text,
//       'disease': diseaseController.text,
//     };
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profit1/services/api_service.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/model/diet_assessment.dart';

class DietAssessmentController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  var isLoading = true.obs;
  var oldDietAssessment = Rxn<OldDietAssessment>();
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
    return {
      'goal': goalController.text,
      'activityLevel': activityLevelController.text,
      'numberOfMeals': int.tryParse(numberOfMealsController.text),
      'dietType': dietTypeController.text,
      'foodAllergens': foodAllergensController.text,
      'disease': diseaseController.text,
      'weight': double.tryParse(weightController.text),
      'bodyFat': double.tryParse(bodyFatController.text),
      'waistArea': double.tryParse(waistAreaController.text),
      'neckArea': double.tryParse(neckAreaController.text),
    };
  }
}


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
        goalController.text = response.fitnessGoals; // Add this line to set the goal
        print("Goal: ${response.fitnessGoals}"); // Debugging print statement
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
