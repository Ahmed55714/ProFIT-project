import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../models/verify_otp.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:4000/api/v1/mobile/traniee";

  Future<bool> signUp(User user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      print('OTP verified: ${response.body}');
      return true;
    } else {
      print('Failed to sign up user: ${response.body}');
      throw Exception('Failed to sign up user');
    }
  }

  Future<String?> verifyOtp(OtpRequest otpRequest) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/verify-otp"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(otpRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      return decodedBody['token'];
    } else {
      print('Failed to verify OTP: ${response.body}');
      return null;
    }
  }

  Future<bool> resendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/resend-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postFitnessProfile(
      Map<String, dynamic> profileData, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/basic-info"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to post profile data: ${response.body}');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/signin"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      String token = body['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      await prefs.setBool('onboardingComplete', true);

      return true;
    } else {
      print('Failed to sign in: ${response.body}');
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/forget-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('OTP verified: ${response.body}');
      return true;
    } else {
      print('Failed to send reset password link: ${response.body}');
      return false;
    }
  }

  Future<bool> resetPassword(
      String otp, String newPassword, String confirmPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'OTP': otp,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      print('Password reset successfully: ${response.body}');
      return true;
    } else {
      // Handle failure
      print('Failed to reset password: ${response.body}');
      print(otp);
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
