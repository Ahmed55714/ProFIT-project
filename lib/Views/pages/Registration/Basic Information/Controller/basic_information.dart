import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import '../../../../../services/api_service.dart';

class StepProgressController extends GetxController {
  final RxString gender = 'Male'.obs;
  final Rx<DateTime> birthDate = DateTime.now().obs;
  final RxInt height = 0.obs;
  final RxDouble weight = 0.0.obs;
  final RxString fitnessGoals = ''.obs;
  final RxString activityLevel = ''.obs;

  ApiService apiService = ApiService();

  // Method to set the gender
  void setGender(String selectedGender) {
    gender.value = selectedGender;
  }

  // Method to set the birth date
  void setBirthDate(DateTime selectedDate) {
    birthDate.value = selectedDate;
  }

  // Method to set the height
  void setHeight(int selectedHeight) {
    height.value = selectedHeight;
  }

  // Method to set the weight
  void setWeight(double selectedWeight) {
    weight.value = selectedWeight;
  }

  // Method to set the fitness goals
  void setFitnessGoals(String selectedFitnessGoals) {
    fitnessGoals.value = selectedFitnessGoals;
  }

  // Method to set the activity level
  void setActivityLevel(String selectedActivityLevel) {
    activityLevel.value = selectedActivityLevel;
  }

  // Method to post the user fitness profile
  Future<void> finishProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      Map<String, dynamic> profileData = {
        'gender': gender.value,
        'birthDate': birthDate.value.toIso8601String(),
        'weight': weight.value,
        'height': height.value,
        'fitnessGoals': fitnessGoals.value,
        'activityLevel': activityLevel.value,
      };

      bool success = await apiService.postFitnessProfile(profileData, token);

      if (success) {
        Get.offAll(() => BottomNavigation(selectedIndex: 0, role: 'Home'));
      } else {
        Get.snackbar('Error', 'Failed to post data');
      }
    } else {
      Get.snackbar('Error', 'Authentication token not found');
    }
  }
}
