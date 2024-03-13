import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/map_place.dart';
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
  var body = json.encode(profile); 
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
static Future<List<Place>> searchPlaces(String searchTerm) async {
    // Note: Replace 'YOUR_API_KEY' with your actual Google Maps API key
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchTerm&key=AIzaSyDwproMFUGZzFhwlDh8YL4ULifz_tK7H-o');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = List<Map<String, dynamic>>.from(data['results']);
      return results.map((result) => Place.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
 
}
