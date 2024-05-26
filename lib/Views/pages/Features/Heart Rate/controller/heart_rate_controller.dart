import 'dart:math';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/api_service.dart';
import '../heart_rate.dart';
import 'dart:async';

class HeartRateController extends GetxController {
  final ApiService apiService = ApiService();
  var bmi = 0.0.obs;
  var heartRate = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBmi();
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
      print('BMI updated: ${bmi.value}');
    } else {
      print('Failed to update BMI');
    }
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
    return await apiService.postHeartRate(heartRate, token);
  }

  void startHeartRateMeasurement() {
    Timer(Duration(seconds: 2), () {
      int simulatedBPM = 80 + Random().nextInt(31); 
      postHeartRateData(simulatedBPM);
      heartRate.value = simulatedBPM;
      print('Simulated BPM: $simulatedBPM');
    });
  }
}
