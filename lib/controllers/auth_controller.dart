import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/verify_otp.dart';
import '../services/api_service.dart';


class UserController extends GetxController {
  final ApiService apiService = ApiService();
  final Rx<User> user = User(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    phoneNumber: '',
  ).obs;

  void setFirstName(String firstName) => user.update((val) => val?.firstName = firstName);
  void setLastName(String lastName) => user.update((val) => val?.lastName = lastName);
  void setEmail(String email) => user.update((val) => val?.email = email);
  void setPassword(String password) => user.update((val) => val?.password = password);
  void setPhoneNumber(String phoneNumber) => user.update((val) => val?.phoneNumber = phoneNumber);

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

        Get.snackbar('Success', 'OTP verified successfully! Token saved.');
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
}


Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');
  return token;
}




// Future<bool> verifyOtp(String email, String otp) async {
  //   isLoading.value = true;
  //   try {
  //     final response = await apiService.verifyOtp(email, otp);
  //     final body = json.decode(response.body);

  //     if (response.statusCode == 200 && body['token'] != null) {
  //       String token = body['token'];
  //       await saveToken(token);
  //       Get.snackbar('Success', 'OTP verification successful');
  //       print("Saved token: $token");
  //       return true;
  //     } else {
  //       Get.snackbar('Error', 'OTP verification failed');
  //       print('OTP verification failed: ${response.body}');
  //       return false;
  //     }
  //   } on Exception catch (e) {
  //     Get.snackbar('Error', 'OTP verification failed: $e');
  //     print('OTP verification failed: $e');
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('auth_token', token);
  //   print("Token saved: $token");
  // }