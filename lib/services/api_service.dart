import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:profit1/Views/pages/Profile/Account/Personal%20Data/Model/personal_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Views/pages/Explore/About/model/trainer_about.dart';
import '../Views/pages/Explore/Free Plans/model/free_plan.dart';
import '../Views/pages/Explore/Package/model/package.dart';
import '../Views/pages/Explore/Package/model/subscription_details.dart';
import '../Views/pages/Explore/Reviews/model/reviews.dart';
import '../Views/pages/Explore/Transformation/model/transformation.dart';
import '../Views/pages/Features/Chat/model/chat_list.dart';
import '../Views/pages/Features/Heart Rate/model/heart_rate.dart';
import '../Views/pages/Features/Steps/model/graphSteps.dart';
import '../Views/pages/Profile/Account Data/Model/account_data.dart';
import '../Views/pages/Profile/Account/Assessment/Old Diet Assessment/model/list_old_assessment.dart';
import '../Views/pages/Profile/Account/Assessment/model/old_diet_assessment.dart';
import '../Views/pages/Registration/model/user.dart';
import '../Views/pages/Tabs/Explore/model/nutration.dart';
import '../Views/pages/Tabs/Explore/model/trainer.dart';
import '../Views/pages/Registration/forgotPasswordScreens/Model/verify_otp.dart';
import '../Views/pages/Tabs/More/My Progress/Measurements/model/model.dart';
import '../Views/pages/Tabs/More/My Progress/Photo/model/photo.dart';
import '../Views/pages/Tabs/home/challenges/model/challanges.dart';
import 'socket_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late SocketService socketService;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    socketService = SocketService();
  }

  final String baseUrl = "https://pro-fit.onrender.com/api/v1/trainees";
  final String baseUrl2 =
      "https://pro-fit.onrender.com/api/v1/chat/conversations";
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
      return true;
    } else {
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
      return true;
    } else {
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
      return true;
    } else {
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
      return true;
    } else {
 
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
        return AccountData.fromJson(data['data']);
      }
    } else {
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
        return PersonalData.fromJson(data['data']);
      }
    } else {
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
      return true;
    } else {
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

  Future<List<TransformationDetails>> fetchTransformationDetails(
      String trainerId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      return [];
    }

    var uri = Uri.parse('$baseUrl/trainers/$trainerId/transformations');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true &&
          data.containsKey('data') &&
          data['data'].isNotEmpty) {
        return (data['data'] as List)
            .map((e) => TransformationDetails.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } else {
      // print(
      throw Exception(
          'Failed to fetch transformations: HTTP status ${response.statusCode}');
    }
  }

  Future<List<DietPlan>> fetchFreeDietPlans(
      String token, String trainerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trainers/$trainerId/free-plans'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => DietPlan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load diet plans');
    }
  }

  Future<ReviewsData?> fetchTrainerReviews(String trainerId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/trainers/$trainerId/reviews'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] && data.containsKey('data')) {
        return ReviewsData.fromJson(data['data']);
      } else {
        return null;
      }
    } else {
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
      // print('Trainers fetched by specialization: ${response.body}');
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      var error = jsonDecode(response.body);
      throw Exception(
          'Failed to load trainers by specialization: ${error['message']} Status ${response.statusCode}');
    }
  }

  Future<List<NutritionPlan>> fetchNutritionPlans(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/trainers/diet-free-plans'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return (data['data'] as List)
            .map((plan) => NutritionPlan.fromJson(plan))
            .toList();
      } else {
        throw Exception('Failed to load nutrition plans');
      }
    } else {
      throw Exception('Failed to load nutrition plans');
    }
  }

  Future<Map<String, dynamic>> toggleFavoriteDiet(
      String planId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/trainers/$planId/diet-toggle-favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to toggle favorite status');
    }
  }

  Future<List<NutritionPlan>> fetchFavoriteDiet(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites/free-diet-plan'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((plan) => NutritionPlan.fromJson(plan))
          .toList();
    } else {
      throw Exception('Failed to fetch favorite nutrition plans');
    }
  }

  Future<void> toggleFavorite(String trainerId, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/trainers/$trainerId/trainer-toggle-favorite"),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<List<Trainer>> fetchFavoriteTrainers(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/favorites/trainers'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      // print('Favorite trainers fetched successfully: ${response.body}');
      return body.map((dynamic item) => Trainer.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to fetch favorite trainers: Status ${response.statusCode}');
    }
  }

  Future<List<Package>> getPackagesById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      // print('Auth token not found');
      throw Exception('Auth token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/subscription/getPackages/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );


    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      // print('Data Received: $data');
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
      } else {
        throw Exception('Failed to select package');
      }
    } else {
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
        return SubscriptionDetails.fromJson(data['data']);
      } else {
        throw Exception('Invalid or missing data');
      }
    } else {
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
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to subscribe to package: ${response.statusCode} ${response.body}');
    }
  }

  Future<OldDietAssessmentInformation?> fetchSpecificDietAssessment(
      String token, String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/DietAssessment/getSpecificDietAssessment/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      return OldDietAssessmentInformation.fromJson(jsonData);
    } else {
      throw Exception('Failed to load specific diet assessment');
    }
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
      return true;
    } else {
      return false;
    }
  }

  Future<HeartRate?> fetchLatestHeartRate(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/heart-rate"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return HeartRate.fromJson(data['data']);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchDietAssessmentsData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final response = await http.get(
      Uri.parse('$baseUrl/DietAssessment/getDietAssessmentsData'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to fetch diet assessments data');
    }
  }

  Future<void> submitDietAssessment(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final response = await http.post(
      Uri.parse('$baseUrl/DietAssessment/FillDietAssessment'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit diet assessment');
    }
  }

  Future<Map<String, dynamic>> submitReview(
      String trainerId, int rating, String comment) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      return {'success': false, 'message': 'Authentication token not found'};
    }

    final response = await http.post(
      Uri.parse('$baseUrl/trainers/$trainerId/reviews'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'rating': rating,
        'comment': comment,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'success': false, 'message': 'Review submitted successfully'};
    }
  }

  Future<List<int>> fetchStepGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/steps/step-goals'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return List<int>.from(data['data']);
      } else {
        throw Exception('Failed to fetch step goals');
      }
    } else {
      throw Exception('Failed to fetch step goals: ${response.reasonPhrase}');
    }
  }

  Future<bool> postStepGoal(int stepGoal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/steps/goal'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'stepGoal': stepGoal}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['success']) {
        return true;
      } else {
        throw Exception('Failed to set step goal');
      }
    } else {
      throw Exception('Failed to set step goal: ${response.reasonPhrase}');
    }
  }

  Future<bool> postSteps(int steps, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/steps"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'steps': steps}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> getWaterIntake(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/water"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to fetch water intake');
    }
  }

  Future<bool> postWaterIntake(int intake, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/water"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'intake': intake}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fillAllWaterIntake(String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/water/fill-all"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetWaterIntake(String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/water/reset"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setWaterGoal(int goal, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/water/goal'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'waterGoal': goal}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<http.Response> postSleepData(
      String token, String fallAsleepTime, String wakeUpTime) async {
    final url = "$baseUrl/sleeping-track";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'fallAsleepTime': fallAsleepTime,
      'wakeUpTime': wakeUpTime,
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
    }

    return response;
  }

  Future<http.Response> fetchLatestSleepData(String token) async {
    final url = "$baseUrl/sleeping-track";
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  Future<bool> addChallenge(String token, String title, File image) async {
    var uri = Uri.parse("$baseUrl/challenge");
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token';

    request.fields['title'] = title;

    String mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
    if (!mimeType.startsWith('image/') && mimeType != 'application/pdf') {
      return false;
    }

    request.files.add(await http.MultipartFile.fromPath(
      'challengeImage',
      image.path,
      contentType: MediaType.parse(mimeType),
    ));

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);


    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Challenge>> fetchChallenges(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/challenge'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((challenge) => Challenge.fromJson(challenge)).toList();
    } else {
      throw Exception('Failed to load challenges');
    }
  }

  Future<bool> giveUpChallenge(String challengeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      final response = await http.post(
        Uri.parse('$baseUrl/challenge/giveup/$challengeId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addPhoto(String token, String title, File image) async {
    var uri = Uri.parse("$baseUrl/progress/photo");
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token';

    String mimeType = lookupMimeType(image.path) ?? 'application/octet-stream';
    if (!mimeType.startsWith('image/') && mimeType != 'application/pdf') {
      return false;
    }

    request.files.add(await http.MultipartFile.fromPath(
      'progressImage',
      image.path,
      contentType: MediaType.parse(mimeType),
    ));

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);


    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/progress/photo'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return (data['data'] as List)
            .map((photo) => Photo.fromJson(photo))
            .toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }

  Future<bool> deletePhoto(String photoId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/progress/photo/$photoId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete photo: ${response.statusCode}');
    }
  }

  Future<bool> deleteChallenge(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/challenge/$challengeId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to delete challenge: ${response.body}');
    }
  }

  Future<MeasurementsData> fetchMeasurements() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/progress/measurements'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return MeasurementsData.fromJson(data['data']);
      } else {
        throw Exception('Failed to load measurements');
      }
    } else {
      throw Exception('Failed to load measurements: ${response.statusCode}');
    }
  }

  Future<List<Conversation>> fetchConversations() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse(baseUrl2),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return (data['data'] as List)
            .map((conversation) => Conversation.fromJson(conversation))
            .toList();
      } else {
        throw Exception('Failed to load conversations');
      }
    } else {
      throw Exception('Failed to load conversations: ${response.statusCode}');
    }
  }

  Future<String> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') ?? '';
  }

  Future<String> uploadImage(File imageFile) async {
    final uri = Uri.parse('$baseUrl/upload');

    var request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final json = jsonDecode(responseBody);
      return json['messageImage'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  void sendMessage(
      String conversationId, String content, List<String> images) async {
    final message = {
      'conversationId': conversationId,
      'content': content.isNotEmpty ? content : ' ',
      'images': images,
    };

    socketService.sendMessage(conversationId, content, images);
  }

  Future<List<Message>> fetchMessages(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl2/$conversationId/messages'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data.containsKey('data')) {
        return (data['data'] as List)
            .map((message) => Message.fromJson(message))
            .toList();
      } else {
        throw Exception('Failed to load messages');
      }
    } else {
      throw Exception('Failed to load messages: ${response.statusCode}');
    }
  }

  Future<List<OldDietAssessment>> fetchOldDietAssessments(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/DietAssessment/DietAssessmentsList'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => OldDietAssessment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load diet assessments');
    } 
  }

  Future<Map<String, dynamic>> fetchNutritionPlanDetails(
      String token, String planId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Diet/dietPlanOverview/$planId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load nutrition plan details');
    }
  }

  Future<void> postStartDate(
      String token, String planId, String startDate) async {
    final url = Uri.parse('$baseUrl/Diet/subscribeToFreeDietPlan/$planId');
    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };
    final body = json.encode({'startDate': startDate});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
    } else {
    }
  }



  Future<Map<String, dynamic>> getDietPlanOverview(
      String id, String token) async {
    final url = Uri.parse('$baseUrl/Diet/dietPlanOverview/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load diet plan overview');
    }
  }

  

  Future<Map<String, dynamic>?> getDietPlanDetails(
      String planId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Diet/getDietPlan'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  


Future<List<WeeklySteps>> fetchWeeklySteps() async {
   final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    final response = await http.get(
      
      Uri.parse('$baseUrl/steps/weekly-steps'),
        headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      return body.map((dynamic item) => WeeklySteps.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load weekly steps');
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
