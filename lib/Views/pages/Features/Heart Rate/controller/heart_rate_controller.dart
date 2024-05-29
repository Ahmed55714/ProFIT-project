import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/api_service.dart';
import '../heart_rate.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class HeartRateController extends GetxController {
  final ApiService apiService = ApiService();
  var bmi = 0.0.obs;
  var heartRate = 0.obs;

  @override
  void onInit() {
    super.onInit();
    requestSensorPermission();
    loadHeartRateFromPreferences();
  }

  Future<void> requestSensorPermission() async {
    var status = await Permission.sensors.status;
    if (!status.isGranted) {
      if (await Permission.sensors.request().isGranted) {
        print('Permission granted');
        fetchBmi();
      } else {
        print('Permission denied');
      }
    } else {
      fetchBmi();
    }
  }

  Future<void> fetchBmi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Token not found');
      return;
    }

    double? fetchedBmi = await apiService.fetchBmi(token);
    if (fetchedBmi != null) {
      bmi.value = fetchedBmi;
      await prefs.setDouble('bmi', fetchedBmi);
      print('BMI updated: ${bmi.value}');
    } else {
      print('Failed to update BMI');
    }
  }

  Future<void> loadBmiFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bmi.value = prefs.getDouble('bmi') ?? 0.0; // Load BMI from SharedPreferences
  }

  Future<void> loadHeartRateFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    heartRate.value = prefs.getInt('heart_rate') ?? 0; // Load heart rate from SharedPreferences
  }

  Future<void> saveHeartRateToPreferences(int bpm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('heart_rate', bpm); // Save heart rate to SharedPreferences
  }

  Future<bool> postHeartRateData(int bpm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Token not found');
      return false;
    }

    HeartRate heartRate = HeartRate(bpm: bpm);
    print(heartRate.bpm);

    bool result = await apiService.postHeartRate(heartRate, token);
    if (result) {
      await saveHeartRateToPreferences(bpm);
    }
    return result;
  }
}
