import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:profit1/Views/pages/Profile/Account/Personal%20Data/Model/personal_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Views/pages/Explore/About/model/trainer_about.dart';
import '../Views/pages/Explore/Package/model/package.dart';
import '../Views/pages/Explore/Package/model/subscription_details.dart';
import '../Views/pages/Explore/Reviews/model/reviews.dart';
import '../Views/pages/Explore/Transformation/model/transformation.dart';
import '../Views/pages/Features/Heart Rate/heart_rate.dart';
import '../Views/pages/Profile/Account Data/Model/account_data.dart';
import '../Views/pages/Profile/Account/Assessment/model/diet_assessment.dart';
import '../Views/pages/Registration/model/user.dart';
import '../Views/pages/Tabs/Explore/model/trainer.dart';
import '../Views/pages/forgotPasswordScreens/Model/verify_otp.dart';

class ApiService {
  final String baseUrl = "https://profit-qjbo.onrender.com/api/v1/trainees";
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Profile data posted successfully: ${response.body}');
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
      print('OTP verified: ${response.body}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      await prefs.setBool('onboardingComplete', true);
      print('Token: $token');
      print('OTP verified: ${response.body}');
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
        print(token);
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
      ..files.add(
          await http.MultipartFile.fromPath('profilePhoto', imageFile.path));

    var response = await request.send();

    return response.statusCode == 200;
  }

  Future<bool> updateAccountData(
      String token,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      File? imageFile) async {
    var uri = Uri.parse("$baseUrl/profile/account-data");
    var request = http.MultipartRequest('PATCH', uri)
      ..headers['Authorization'] = 'Bearer $token';

    if (imageFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profilePhoto', imageFile.path));
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
        //  print('Account deleted successfully: ${response.body}');
        return true;
      } else {
        //    print('Failed to delete account: ${response.body}');
        return false;
      }
    } catch (e) {
      //   print('Error deleting account: $e');
      return false;
    }
  }

  Future<List<Trainer>> fetchAllTrainers(String token) async {
    final response = await http.get(Uri.parse('$baseUrl/trainers'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      var error = jsonDecode(response.body);
      throw Exception(
          'Failed to load trainers: ${error['message']} Status ${response.statusCode}');
    }
  }

  Future<TrainerAbout?> fetchTrainerAbout(String trainerId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/trainers/$trainerId/about'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return TrainerAbout.fromJson(data['data']);
      }
    }
    throw Exception('Failed to load trainer details');
  }

  Future<TransformationDetails?> fetchTransformationDetails(
      String trainerId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Authentication token not found');
      return null;
    }

    var uri = Uri.parse('$baseUrl/trainers/$trainerId/transformations');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    print('Fetching transformations for trainer ID: $trainerId from: $uri');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true &&
          data.containsKey('data') &&
          data['data'].isNotEmpty) {
        print('Transformations fetched successfully: ${response.body}');
        return TransformationDetails.fromJson(data['data'][0]);
      } else {
        print('Data fetched but no transformations found');
        return null;
      }
    } else {
      print(
          'Failed to fetch transformations: HTTP status ${response.statusCode} - ${response.body}');
      throw Exception(
          'Failed to fetch transformations: HTTP status ${response.statusCode}');
    }
  }

  Future<ReviewsData?> fetchTrainerReviews(String trainerId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Authentication token not found');
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/trainers/$trainerId/reviews'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('Fetching reviews for trainer ID: $trainerId');
    print('Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] && data.containsKey('data')) {
        return ReviewsData.fromJson(data['data']);
      } else {
        print('Reviews fetched but no data found');
        return null;
      }
    } else {
      print(
          'Failed to fetch reviews: HTTP status ${response.statusCode} - ${response.body}');
      throw Exception(
          'Failed to fetch reviews: HTTP status ${response.statusCode}');
    }
  }

  Future<List<Trainer>> fetchTrainers(String token,
      {String sort = 'dasc'}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trainers?sort=$sort'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      print('Trainers fetched successfully: ${response.body}');
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      var error = jsonDecode(response.body);
      throw Exception(
          'Failed to load trainers: ${error['message']} Status ${response.statusCode}');
    }
  }

  Future<List<Trainer>> fetchTrainersBySpecialization(
      String token, String specialization, String sort) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trainers?specialization=$specialization&sort=$sort'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      print('Trainers fetched by specialization: ${response.body}');
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      var error = jsonDecode(response.body);
      throw Exception(
          'Failed to load trainers by specialization: ${error['message']} Status ${response.statusCode}');
    }
  }

  Future<void> toggleFavorite(String trainerId, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/trainers/$trainerId/toggle-favorite"),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.body);
  }

  Future<List<Trainer>> fetchFavoriteTrainers(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      print('Favorite trainers fetched successfully: ${response.body}');
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      print('Failed to fetch favorite trainers: ${response.body}');
      throw Exception(
          'Failed to fetch favorite trainers: Status ${response.statusCode}');
    }
  }

  Future<List<Package>> getPackagesById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      print('Auth token not found');
      throw Exception('Auth token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/subscription/getPackages/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      print('Data Received: $data');
      return data.map((pkg) => Package.fromJson(pkg)).toList();
    } else {
      throw Exception('${response.statusCode} - ${response.body}');
    }
  }

  Future<void> selectPackage(String packageId, String token) async {
    var response = await http.patch(
      Uri.parse('$baseUrl/subscription/selectPackage/$packageId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (data["success"] == true) {
        print('Package selected successfully: ${response.body}');
      } else {
        print(
            'Failed to select package: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to select package');
      }
    } else {
      print(
          'Failed to select package: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to select package');
    }
  }

  Future<SubscriptionDetails> fetchSubscriptionDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    var response = await http.get(
      Uri.parse('$baseUrl/subscription/subscriptionDetails/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (data != null && data['data'] != null) {
        print('Subscription details fetched successfully: ${response.body}');
        return SubscriptionDetails.fromJson(data['data']);
      } else {
        print('Invalid or missing data: ${response.body}');
        throw Exception('Invalid or missing data');
      }
    } else {
      print('Failed to load subscription details: Status ${response.body}');
      throw Exception(
          'Failed to load subscription details: Status ${response.statusCode}');
    }
  }

  Future<dynamic> subscribeToPackage(String packageId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final String url = '$baseUrl/subscription/subscribe/$packageId';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Subscribed to package successfully: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print(
          'Failed to subscribe to package: ${response.statusCode} ${response.body}');
      throw Exception(
          'Failed to subscribe to package: ${response.statusCode} ${response.body}');
    }
  }

  Future<DietAssessment?> fetchDietAssessment(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/DietAssessment/DietAssessments'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        try {
          final jsonData = jsonDecode(response.body);
          if (jsonData is Map<String, dynamic> &&
              jsonData.containsKey('data')) {
            if (jsonData['data'] != null) {
              if (jsonData['data'] is Map<String, dynamic>) {
                print('Diet assessment fetched successfully: ${response.body}');
                return DietAssessment.fromJson(jsonData['data']);
              } else {
                print(response.body);
                print('Expected "data" to be a Map<String, dynamic>');
              }
            } else {
              print(response.body);
              print('Data is null');
            }
          } else {
            print(
                'Invalid or missing "data" key in JSON response: ${response.body}');
          }
        } catch (e) {
          print('Error decoding JSON: $e, Response body: ${response.body}');
        }
      } else {
        print('Response body is empty');
      }
    } else {
      print(
          'Failed to fetch diet assessment: ${response.statusCode} ${response.body}');
    }
    return null;
  }

  Future<bool> postHeartRate(HeartRate heartRate, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/heart-rate"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(heartRate.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Heart rate data posted successfully: ${response.body}');
      return true;
    } else {
      print('Failed to post heart rate data: ${response.body}');
      return false;
    }
  }

  Future<double?> fetchBmi(String token) async {
  final response = await http.get(
    Uri.parse("$baseUrl/heart-rate"),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print('Fetching BMI...');

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('Response data: $data');

    if (data['success'] == true && data.containsKey('data') && data['data'].containsKey('bpm')) {
      print('BMI fetched successfully: ${data['data']['bpm']}');
      return (data['data']['bpm'] as num).toDouble();
    } else {
      print('Failed to fetch BMI: Key not found');
      return null;
    }
  } else {
    print('Failed to fetch BMI: ${response.body}');
    return null;
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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
