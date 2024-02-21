import 'package:get/get.dart';
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
    bool success = false;
    try {
      success = await apiService.verifyOtp(email, otp);
      if (success) {
        Get.snackbar('Success', 'OTP verification successful');
      } else {
        Get.snackbar('Error', 'OTP verification failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'OTP verification failed: $e');
    } finally {
      isLoading.value = false;
    }
    return success;
  }
}
