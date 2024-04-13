import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../../forgotPasswordScreens/Model/verify_otp.dart';
import '../../../../services/api_service.dart';

class UserController extends GetxController {
  final ApiService apiService = ApiService();
  final Rx<User> user = User(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    phoneNumber: '',
  ).obs;

  void setFirstName(String firstName) =>
      user.update((val) => val?.firstName = firstName);
  void setLastName(String lastName) =>
      user.update((val) => val?.lastName = lastName);
  void setEmail(String email) => user.update((val) => val?.email = email);
  void setPassword(String password) =>
      user.update((val) => val?.password = password);
  void setPhoneNumber(String phoneNumber) =>
      user.update((val) => val?.phoneNumber = phoneNumber);

  Future<void> signUp() async {
    final success = await apiService.signUp(user.value);
    if (success) {
      Get.snackbar('Success', 'User registered successfully!');
    } else {
      Get.snackbar('Error', 'Failed to register user');
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    OtpRequest otpRequest = OtpRequest(email: email, otp: otp);
    try {
      String? token = await apiService.verifyOtp(otpRequest);
      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        Get.snackbar('Success', 'OTP verified successfully!');
        print('Token: $token');

        return true;
      } else {
        // Show error message
        Get.snackbar('Error', 'Failed to verify OTP');
        return false;
      }
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'An error occurred while verifying OTP');
      return false;
    }
  }

  Future<void> resendOtp(String email) async {
    final response = await apiService.resendOtp(email);
    if (response) {
      Get.snackbar('Success', 'OTP has been resent.');
    } else {
      Get.snackbar('Error', 'Failed to resend OTP.');
    }
  }




   Future<void> signIn(String email, String password) async {
    bool success = await apiService.signIn(email, password);
    if (success) {
      Get.snackbar('Success', 'Signed in successfully! Token saved.');
    } else {
      Get.snackbar('Error', 'Failed to sign in.');
    }
  }

Future<void> forgotPassword(String email) async {
    try {
      bool success = await apiService.forgotPassword(email);
      if (success) {
        Get.snackbar('Success', 'A reset password link has been sent to your email.');
      } else {
        Get.snackbar('Error', 'Failed to send reset password link.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  
  Future<void> resetPassword(String email, String otp, String newPassword, String confirmPassword) async {
    if (newPassword == confirmPassword) {
      bool success = await apiService.resetPassword(otp, newPassword, confirmPassword);
      if (success) {
        Get.snackbar('Success', 'Password reset successfully!');
      } else {
        Get.snackbar('Error', 'Failed to reset password.');
      }
    } else {
      Get.snackbar('Error', 'The passwords do not match.');
    }
  }

}

 

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  return token;
}
