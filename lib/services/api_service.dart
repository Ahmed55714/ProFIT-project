import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:4000/api/v1/auth";

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

  Future<bool> verifyOtp(String email, String otp) async {
    final Uri url = Uri.parse("$baseUrl/verify-otp");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'OTP': otp}),
    );
    return true;
  }
}
