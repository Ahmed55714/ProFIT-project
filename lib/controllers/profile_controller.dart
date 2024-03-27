import 'dart:io';
import 'package:get/get.dart';
import '../models/account_data.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final ApiService _apiService = ApiService();
  Rx<Profile?> profile = Rx<Profile?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    String? token = await _getToken();
    if (token != null && token.isNotEmpty) {
      Profile? fetchedProfile = await _apiService.fetchProfile(token);
      if (fetchedProfile != null) {
        profile.value = fetchedProfile;

        Get.snackbar('Success', 'Profile fetched successfully!');
      } else {
        Get.snackbar('Error', 'Failed to fetch profile.');
      }
    } else {
      Get.snackbar('Error', 'Token not found, please sign in again.');
    }
  }

  void updateProfileImage(File image) {
    // Update the profile image locally for now
    // You need to implement the logic to upload the image to the server and update the profile object
    print("Profile image updated locally: ${image.path}");
    // After uploading and successfully saving the image on the server, update the profile observable
    // profile.value = profile.value.copyWith(profilePhoto: newImageUrl);
  }

  void updateFirstName(String firstName) {
    // Update first name locally
    profile.value = profile.value?.copyWith(firstName: firstName);
  }

  void updateLastName(String lastName) {
    // Update last name locally
    profile.value = profile.value?.copyWith(lastName: lastName);
  }

  void updateEmail(String email) {
    // Update email locally
    profile.value = profile.value?.copyWith(email: email);
  }

  void updatePhoneNumber(String phoneNumber) {
    // Update phone number locally
    profile.value = profile.value?.copyWith(phoneNumber: phoneNumber);
  }

  Future<void> saveProfileChanges(File? imageFile, String firstName, String lastName, String email, String phoneNumber) async {
  String? token = await _getToken();
  if (token == null || token.isEmpty) {
    Get.snackbar('Error', 'You must be logged in to update your profile.');
    return;
  }

  bool updated = await _apiService.updateAccountData(token, firstName, lastName, email, phoneNumber, imageFile);
  
  if (updated) {
    await fetchUserProfile();
    Get.snackbar('Success', 'Profile updated successfully!');
  } else {
    Get.snackbar('Error', 'Failed to update profile.');
  }
}


  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
