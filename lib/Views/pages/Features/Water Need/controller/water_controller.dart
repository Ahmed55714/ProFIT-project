import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';

class WaterController extends GetxController {
  final ApiService apiService = ApiService();
  RxInt waterIntake = 0.obs;
  RxInt waterGoal = 2000.obs;
  RxDouble percentageComplete = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWaterIntake();
  }

  Future<void> fetchWaterIntake() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        final data = await apiService.getWaterIntake(token);
        waterIntake.value = data['intake'] ?? 0;
        waterGoal.value = data['goal'] ?? 2000;
        percentageComplete.value = (data['percentageComplete'] ?? 0).toDouble();
      }
    } catch (e) {
      print('Error fetching water intake: $e');
    }
  }

  Future<void> addCup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        bool success = await apiService.postWaterIntake(250, token); // Assuming 250ml per cup
        if (success) {
          waterIntake.value += 250;
          percentageComplete.value = (waterIntake.value / waterGoal.value) * 100;
        }
      }
    } catch (e) {
      print('Error adding cup: $e');
    }
  }

  Future<void> fillAll() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        bool success = await apiService.fillAllWaterIntake(token);
        if (success) {
          waterIntake.value = waterGoal.value;
          percentageComplete.value = 100;
        }
      }
    } catch (e) {
      print('Error filling all water intake: $e');
    }
  }

  Future<void> resetWaterIntake() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        bool success = await apiService.resetWaterIntake(token);
        if (success) {
          waterIntake.value = 0;
          percentageComplete.value = 0.0;
        }
      }
    } catch (e) {
      print('Error resetting water intake: $e');
    }
  }

Future<void> setWaterGoal(int newGoal) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        bool success = await apiService.setWaterGoal(newGoal, token);
        if (success) {
          waterGoal.value = newGoal;
          percentageComplete.value = (waterIntake.value / waterGoal.value) * 100;
        }
      }
    } catch (e) {
      print('Error setting water goal: $e');
    }
  }
}
