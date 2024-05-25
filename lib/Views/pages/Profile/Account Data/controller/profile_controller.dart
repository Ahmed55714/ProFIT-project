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
  Rx<File?> profileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load profile data from local storage
    String? profilePhoto = prefs.getString('profilePhoto');
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? email = prefs.getString('email');
    String? phoneNumber = prefs.getString('phoneNumber');

    if (profilePhoto != null && firstName != null) {
      profile.value = AccountData(
        profilePhoto: profilePhoto,
        firstName: firstName,
        lastName: lastName ?? '',
        email: email ?? '',
        phoneNumber: phoneNumber?? '',
         id:  '',
      );
      fetchImage(profilePhoto);
    } else {
      fetchUserProfile();
    }
  }

  Future<void> fetchUserProfile() async {
    String? token = await _getToken();
    if (token != null && token.isNotEmpty) {
      AccountData? fetchedProfile = await _apiService.fetchProfile(token);
      if (fetchedProfile != null) {
        profile.value = fetchedProfile;

        // Save fetched data to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profilePhoto', fetchedProfile.profilePhoto ?? '');
        await prefs.setString('firstName', fetchedProfile.firstName ?? '');
        await prefs.setString('lastName', fetchedProfile.lastName ?? '');
        await prefs.setString('email', fetchedProfile.email ?? '');
        await prefs.setString('phoneNumber', fetchedProfile.phoneNumber ?? '');

        fetchImage(fetchedProfile.profilePhoto ?? '');
      }
    }
  }

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

        // Save the image URL to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profilePhoto', url);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error fetching image: $e');
      profileImage.value = null;
    }
  }

  void updateProfileImage(File image) {
    profileImage.value = image;
    _saveImageLocally(image.path);
  }

  Future<void> _saveImageLocally(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePhoto', imagePath);
  }

  void updateFirstName(String firstName) {
    profile.value = profile.value?.copyWith(firstName: firstName);
    _saveProfileData();
  }

  void updateLastName(String lastName) {
    profile.value = profile.value?.copyWith(lastName: lastName);
    _saveProfileData();
  }

  void updateEmail(String email) {
    profile.value = profile.value?.copyWith(email: email);
    _saveProfileData();
  }

  void updatePhoneNumber(String phoneNumber) {
    profile.value = profile.value?.copyWith(phoneNumber: phoneNumber);
    _saveProfileData();
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

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', profile.value?.firstName ?? '');
    await prefs.setString('lastName', profile.value?.lastName ?? '');
    await prefs.setString('email', profile.value?.email ?? '');
    await prefs.setString('phoneNumber', profile.value?.phoneNumber ?? '');
  }
}
