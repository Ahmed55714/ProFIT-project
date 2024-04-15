// ProfileController.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Personal%20Data/Model/personal_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../services/api_service.dart';

class PersonalDataController extends GetxController {
  final ApiService apiService = ApiService();

  final Rx<PersonalData?> profileData = Rx<PersonalData?>(null);

  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    String? token = await _getToken();
    if (token != null) {
      PersonalData? profile = await apiService.fetchPersonalData(token);
      if (profile != null) {
        profileData.value = profile;
        genderController.text = profile.gender ?? '';
        birthDateController.text = profile.birthDate ?? '';
        weightController.text = profile.weight?.toStringAsFixed(2) ?? '';
        heightController.text = profile.height?.toString() ?? '';
        activityLevelController.text = profile.activityLevel ?? '';
        update();
      }
    }
  }
void updateUserData() async {
    String? token = await _getToken();
    if (token != null && profileData.value != null) {
      bool success = await apiService.updatePersonalData(
        token,
        PersonalData(
          gender: genderController.text,
          birthDate: birthDateController.text,
          weight: double.tryParse(weightController.text),
          height: double.tryParse(heightController.text),
          activityLevel: activityLevelController.text,
        ),
      );
      
      if (success) {
        Get.snackbar('Success', 'Data updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update data');
      }
    }
  }









  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }


}


 

