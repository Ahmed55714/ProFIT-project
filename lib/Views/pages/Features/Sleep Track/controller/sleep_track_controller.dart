import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;
import 'package:intl/intl.dart';

import '../../../../../services/api_service.dart';

class SleepTrackController extends GetxController {
  ApiService apiservice = ApiService();
  var startAngle = 0.0.obs;
  var endAngle = 0.0.obs;
  var isDraggingStart = false.obs;
  var isDraggingEnd = false.obs;
  var hoursSlept = ''.obs;
  var fallAsleepTime = ''.obs;
  var wakeUpTime = ''.obs;
  var dateRecorded = ''.obs;

  void updateStartAngle(double angle) {
    startAngle.value = angle;
  }

  void updateEndAngle(double angle) {
    endAngle.value = angle;
  }

  String formatTime(double angle) {
    final totalMinutes = ((angle + (math.pi / 2)) / (2 * math.pi) * 720).round();
    final hours = (totalMinutes ~/ 60) % 12;
    final minutes = totalMinutes % 60;
    final period = totalMinutes < 360 ? 'AM' : 'PM';
    final formattedHours = hours == 0 ? 12 : hours;
    return '${formattedHours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';
  }

  Future<void> saveSleepTrack() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      String fallAsleepTime = formatTime(startAngle.value);
      String wakeUpTime = formatTime(endAngle.value);

      var response = await apiservice.postSleepData(token, fallAsleepTime, wakeUpTime);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);
        print(body);
      }
    }
  }

  Future<void> fetchLatestSleepData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      var response = await apiservice.fetchLatestSleepData(token);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var data = body['data'];
        hoursSlept.value = data['hoursSlept'];
        fallAsleepTime.value = data['fallAsleepTime'];
        wakeUpTime.value = data['wakeUpTime'];
        dateRecorded.value = data['dateRecorded'];
      }
    }
  }
}
