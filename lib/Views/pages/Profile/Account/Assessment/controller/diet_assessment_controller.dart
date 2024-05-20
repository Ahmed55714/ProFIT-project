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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/model/diet_assessment.dart';
import '../../../../../../services/api_service.dart';

class DietAssessmentController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  var isLoading = RxBool(true);
  var oldDietAssessment = Rxn<OldDietAssessment>();
  var errorMessage = ''.obs;

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

  @override
  void onInit() {
    super.onInit();
    loadDietAssessment();
    fetchOldDietAssessment();
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

      var assessment = await apiService.fetchOldDietAssessment(token);
      if (assessment != null) {
        oldDietAssessment.value = assessment;
      } else {
        errorMessage('Failed to fetch old diet assessment data');
      }
    } catch (e) {
      errorMessage('Failed to fetch old diet assessment data: $e');
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
    };
  }
}
