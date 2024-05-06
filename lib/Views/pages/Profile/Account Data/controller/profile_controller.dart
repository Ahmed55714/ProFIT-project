import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../Model/account_data.dart';
import '../../../../../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final ApiService _apiService = ApiService();
  Rx<AccountData?> profile = Rx<AccountData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    String? token = await _getToken();
    if (token != null && token.isNotEmpty) {
      AccountData? fetchedProfile = await _apiService.fetchProfile(token);
      if (fetchedProfile != null) {
        profile.value = fetchedProfile;

       // Get.snackbar('Success', 'Profile fetched successfully!');
      } else {
       // Get.snackbar('Error', 'Failed to fetch profile.');
      }
    } else {
     // Get.snackbar('Error', 'Token not found, please sign in again.');
    }
  }

  void updateProfileImage(File image) {
    print("Profile image updated locally: ${image.path}");
  }

  void updateFirstName(String firstName) {
    profile.value = profile.value?.copyWith(firstName: firstName);
  }

  void updateLastName(String lastName) {
    profile.value = profile.value?.copyWith(lastName: lastName);
  }

  void updateEmail(String email) {
    profile.value = profile.value?.copyWith(email: email);
  }

  void updatePhoneNumber(String phoneNumber) {
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

 var profileImage = Rx<File?>(null);

  Future<void> fetchImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final imagePath = '${dir.path}/profile.jpg';
        File image = File(imagePath);
        await image.writeAsBytes(bytes);
        profileImage.value = image;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error fetching image: $e');
      profileImage.value = null; 
    }
  }

   void deleteAccount(BuildContext context) async {
    Get.back();
    bool deleted = await _apiService.deleteAccount();
    if (deleted) {
      await _apiService.clearToken();
      Get.offAllNamed('/sign-up'); 
    } else {
      Get.snackbar('Error', 'Failed to delete the account');
    }
  }
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
