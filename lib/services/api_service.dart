import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../models/user_fitness_profile.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:4000/api/v1/auth";
  final String baseUrl1 = "http://10.0.2.2:4000/api/v1/traniees";

  Future<bool> signUp(User user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user),
    );

    return true;
  }

 Future<http.Response> verifyOtp(String email, String otp) async {
    final Uri url = Uri.parse("$baseUrl/verify-otp");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    return response;
  }
 
Future<bool> postUserFitnessProfile(Map<String, dynamic> profile, String token) async {
  final Uri url = Uri.parse("$baseUrl1/basic-info");
  // Directly encode the profile map to a JSON string
  var body = json.encode(profile); // Corrected line
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', 
    },
    body: body,
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Failed to post user fitness profile: ${response.body}');
    return false;
  }
}




  
}
