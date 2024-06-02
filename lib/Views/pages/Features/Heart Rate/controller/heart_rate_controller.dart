import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../services/api_service.dart';
import '../heart_rate.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/heart_rate.dart';

class HeartRateController extends GetxController {
  final ApiService apiService = ApiService();
  var bmi = 0.0.obs;
  var heartRate = 0.obs;
  var heartRateData = HeartRate(
    id: '',
    trainee: '',
    bpm: 0,
    createdAt: '',
    updatedAt: '',
    v: 0,
  ).obs;
  var formattedDate = ''.obs;

  @override
  void onInit() {
    super.onInit();

    requestPermissions();

    fetchHeartRateData();
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sensors,
      Permission.activityRecognition,
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      print('All permissions granted');
      
    } else {
      print('One or more permissions denied');
    }
  }


  Future<bool> postHeartRateData(int bpm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Token not found');
      return false;
    }

    HeartRate heartRate = HeartRate(
      id: '',
      trainee: '',
      bpm: bpm,
      createdAt: '',
      updatedAt: '',
      v: 0,
    );

    bool result = await apiService.postHeartRate(heartRate, token);
    if (result) {
      fetchHeartRateData();
    }
    return result;
  }

  Future<void> fetchHeartRateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      print('Token not found');
      return;
    }

    HeartRate? fetchedHeartRateData =
        await apiService.fetchLatestHeartRate(token);
    if (fetchedHeartRateData != null) {
      heartRateData.value = fetchedHeartRateData;
      heartRate.value = fetchedHeartRateData.bpm;
      formattedDate.value = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(fetchedHeartRateData.createdAt));
      print('Heart Rate updated: ${heartRate.value}');
      print('Formatted Date: ${formattedDate.value}');
    } else {
      print('Failed to fetch heart rate data');
    }
  }
}
