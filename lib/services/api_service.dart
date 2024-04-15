import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:profit1/Views/pages/Profile/Account/Personal%20Data/Model/personal_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Views/pages/Profile/Account Data/Model/account_data.dart';
import '../Views/pages/Registration/model/user.dart';
import '../Views/pages/forgotPasswordScreens/Model/verify_otp.dart';

class ApiService {
  final String baseUrl =
      "https://profit-server.onrender.com/api/v1/mobile/trainee";
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

  Future<AccountData?> fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile/account-data'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        print('Profile fetched successfully: ${response.body}');
        return AccountData.fromJson(data['data']);
      }
    } else {
      print('Failed to load profile: ${response.body}');
    }
    return null;
  }
 Future<bool> updateProfileImage(String token, File imageFile) async {
    var uri = Uri.parse("$baseUrl/profile/updateImage");
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('profilePhoto', imageFile.path));

    var response = await request.send();

    return response.statusCode == 200;
  }

 Future<bool> updateAccountData(String token, String firstName, String lastName, String email, String phoneNumber, File? imageFile) async {
  var uri = Uri.parse("$baseUrl/profile/account-data");
  var request = http.MultipartRequest('PATCH', uri)
    ..headers['Authorization'] = 'Bearer $token';

  if (imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath('profilePhoto', imageFile.path));
  }

  // Add other fields
  request.fields['firstName'] = firstName;
  request.fields['lastName'] = lastName;
  request.fields['email'] = email;
  request.fields['phoneNumber'] = phoneNumber;

  var response = await request.send();

  return response.statusCode == 200;
}


Future<PersonalData?> fetchPersonalData(String token) async {
  final response = await http.get(
    Uri.parse('$baseUrl/profile/personal-data'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == true && data.containsKey('data')) {
      print('Personal data fetched successfully: ${response.body}');
      return PersonalData.fromJson(data['data']);
    }
  } else {
    print('Failed to load personal data: ${response.body}');
  }
  return null;
}


Future<bool> updatePersonalData(String token, PersonalData data) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/profile/personal-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      print('Personal data updated successfully: ${response.body}');
      return true;
    } else {
      print('Failed to update personal data: ${response.body}');
      return false;
    }
  }


   Future<bool> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) return false;

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/profile/delete-account'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Account deleted successfully: ${response.body}');
        return true;
      } else {
        print('Failed to delete account: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting account: $e');
      return false;
    }
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}
