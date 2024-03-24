import 'package:http/http.dart' as http;
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
      // Assuming the response returns a JSON object with a 'token' field
      final Map<String, dynamic> decodedBody = jsonDecode(response.body);
      return decodedBody['token'];
    } else {
      // Log the error or handle it as you see fit
      print('Failed to verify OTP: ${response.body}');
      return null; // Explicitly returning null for clarity
    }
  }


 Future<bool> resendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/resend-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email}),
    );

    if (response.statusCode == 200) {
      // OTP resent successfully
      return true;
    } else {
      // Handle errors or unsuccessful attempts
      return false;
    }
  }
}
// Future<bool> postUserFitnessProfile(Map<String, dynamic> profile, String token) async {
//   final Uri url = Uri.parse("$baseUrl1/basic-info");
//   var body = json.encode(profile); 
//   final response = await http.post(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token', 
//     },
//     body: body,
//   );
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     print('Failed to post user fitness profile: ${response.body}');
//     return false;
//   }
// }
// static Future<List<Place>> searchPlaces(String searchTerm) async {
//     // Note: Replace 'YOUR_API_KEY' with your actual Google Maps API key
//     final url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$searchTerm&key=AIzaSyDwproMFUGZzFhwlDh8YL4ULifz_tK7H-o');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final results = List<Map<String, dynamic>>.from(data['results']);
//       return results.map((result) => Place.fromJson(result)).toList();
//     } else {
//       throw Exception('Failed to load places');
//     }
//   }
 