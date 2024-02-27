import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserController extends GetxController {
  final ApiService apiService = ApiService();
  final RxBool isLoading = false.obs;

  // Change the return type to Future<bool>
  Future<bool> signUp(User user) async {
    isLoading(true);
    try {
      bool success = await apiService.signUp(user);
      if (success) {
        Get.snackbar('Success', 'Signup successful');
        print('Signup successful: ${user.toJson()}');
      } else {
        Get.snackbar('Error', 'Signup failed');
        print('Signup failed: ${user.toJson()}');
        printInfo(info: 'Signup failed: ${user.toJson()}');
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Signup failed: $e');
      print('Signup failed: ${user.toJson()}, error: $e');
      return false; // Return false on exception
    } finally {
      isLoading(false);
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    try {
      final response = await apiService.verifyOtp(email, otp);
      final body = json.decode(response.body);

      if (response.statusCode == 200 && body['token'] != null) {
        String token = body['token'];
        await saveToken(token);
        Get.snackbar('Success', 'OTP verification successful');
        print("Saved token: $token");
        return true;
      } else {
        Get.snackbar('Error', 'OTP verification failed');
        print('OTP verification failed: ${response.body}');
        return false;
      }
    } on Exception catch (e) {
      Get.snackbar('Error', 'OTP verification failed: $e');
      print('OTP verification failed: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    print("Token saved: $token");
  }
}
