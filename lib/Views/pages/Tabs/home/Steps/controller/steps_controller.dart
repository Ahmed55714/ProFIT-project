import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';
import '../../../../../../services/api_service.dart';

class StepsController extends GetxController {
  final ApiService apiService = ApiService();
  RxInt steps = 0.obs;
  RxDouble distance = 0.0.obs;
  RxString status = 'unknown'.obs;
  static const double stepLength = 0.762;
  RxInt dailyStepGoal = 5000.obs;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  RestartableTimer? _timer;

  int lastResetSteps = 0;
  DateTime lastResetTime = DateTime.now();
  RxList<int> stepGoals = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    print('StepsController initialized');
    requestActivityRecognitionPermission();
    loadLastReset();
    loadDailyStepGoal();
    fetchStepGoals();
    startDailyPostTimer();
  }

  Future<void> requestActivityRecognitionPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      if (await Permission.activityRecognition.request().isGranted) {
        print('Permission granted');
        initPlatformState();
      } else {
        print('Permission denied');
      }
    } else {
      initPlatformState();
    }
  }

  void onStepCount(StepCount event) {
    int totalSteps = event.steps;
    DateTime now = DateTime.now();

    if (now.difference(lastResetTime).inHours >= 24) {
      resetSteps(totalSteps, now);
    }

    // Stop counting steps if the daily goal is reached or exceeded
    if (steps.value < dailyStepGoal.value) {
      steps.value = totalSteps - lastResetSteps;
      distance.value = steps.value * stepLength / 1000;
    }

    print('Step count: ${steps.value}, Distance: ${distance.value} km');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    status.value = event.status;
    print('Pedestrian status: ${status.value}');
  }

  void onPedestrianStatusError(error) {
    print('Pedestrian Status Error: $error');
    status.value = 'unknown';
  }

  void onStepCountError(error) {
    print('Step Count Error: $error');
    steps.value = 0;
    distance.value = 0.0;
  }

  Future<void> initPlatformState() async {
    try {
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _stepCountStream = Pedometer.stepCountStream;

      _stepCountStream.listen(onStepCount).onError(onStepCountError);
      _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

      print('Streams initialized');
    } catch (e) {
      print('Error initializing platform state: $e');
    }
  }

  Future<void> loadLastReset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastResetSteps = prefs.getInt('lastResetSteps') ?? 0;
    lastResetTime = DateTime.tryParse(prefs.getString('lastResetTime') ?? '') ?? DateTime.now().subtract(Duration(hours: 24));
    print('Last reset steps: $lastResetSteps, Last reset time: $lastResetTime');
  }

  Future<void> saveLastReset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastResetSteps', lastResetSteps);
    await prefs.setString('lastResetTime', lastResetTime.toIso8601String());
    print('Saved last reset steps and time');
  }

  void resetSteps(int currentSteps, DateTime now) {
    lastResetSteps = currentSteps;
    lastResetTime = now;
    saveLastReset();
  }

  Future<void> fetchStepGoals() async {
    try {
      stepGoals.value = await apiService.fetchStepGoals();
      print('Step goals fetched: ${stepGoals.value}');
    } catch (e) {
      print('Error fetching step goals: $e');
    }
  }

  Future<void> setDailyStepGoal(int stepGoal) async {
    try {
      bool success = await apiService.postStepGoal(stepGoal);
      if (success) {
        dailyStepGoal.value = stepGoal;
        saveDailyStepGoal(stepGoal);
        print('New daily step goal set: $stepGoal');
      }
    } catch (e) {
      print('Error setting daily step goal: $e');
    }
  }

  Future<void> saveDailyStepGoal(int stepGoal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyStepGoal', stepGoal);
    print('Daily step goal saved: $stepGoal');
  }

  Future<void> loadDailyStepGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dailyStepGoal.value = prefs.getInt('dailyStepGoal') ?? 5000;
    print('Loaded daily step goal: ${dailyStepGoal.value}');
  }

  void startDailyPostTimer() {
    print('Starting daily post timer');
    DateTime now = DateTime.now();
    DateTime nextPostTime = DateTime(now.year, now.month, now.day, 12);
    if (now.isAfter(nextPostTime)) {
      nextPostTime = nextPostTime.add(Duration(days: 1));
    }
    Duration initialDelay = nextPostTime.difference(now);

    _timer = RestartableTimer(initialDelay, () {
      postDailySteps();
      _timer = RestartableTimer(Duration(hours: 24), postDailySteps);
    });
  }

  Future<void> postDailySteps() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        bool success = await apiService.postSteps(steps.value, token);
        if (success) {
          print('Steps posted successfully');
          resetStepsAfterPost();
        } else {
          print('Failed to post steps');
        }
      } else {
        print('Token not found');
      }
    } catch (e) {
      print('Error posting steps: $e');
    }
  }

  void resetStepsAfterPost() {
    steps.value = 0;
    distance.value = 0.0;
    lastResetSteps = 0;
    saveLastReset();
    print('Steps reset after posting');
  }
}





// import 'package:get/get.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:async/async.dart';
// import 'package:intl/intl.dart';
// import '../../../../../../services/api_service.dart';

// class StepsController extends GetxController {
//   final ApiService apiService = ApiService();
//   RxInt steps = 0.obs;
//   RxDouble distance = 0.0.obs;
//   RxString status = 'unknown'.obs;
//   static const double stepLength = 0.762;
//   RxInt dailyStepGoal = 5000.obs;

//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   RestartableTimer? _timer;

//   int lastResetSteps = 0;
//   DateTime lastResetTime = DateTime.now();
//   RxList<int> stepGoals = <int>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     print('StepsController initialized');
//     requestActivityRecognitionPermission();
//     loadLastReset();
//     loadDailyStepGoal();
//     fetchStepGoals();
//     startDailyPostTimer();
//   }

//   Future<void> requestActivityRecognitionPermission() async {
//     var status = await Permission.activityRecognition.status;
//     if (!status.isGranted) {
//       if (await Permission.activityRecognition.request().isGranted) {
//         print('Permission granted');
//         initPlatformState();
//       } else {
//         print('Permission denied');
//       }
//     } else {
//       initPlatformState();
//     }
//   }

//   void onStepCount(StepCount event) {
//     int totalSteps = event.steps;
//     DateTime now = DateTime.now();

//     if (now.difference(lastResetTime).inHours >= 24) {
//       resetSteps(totalSteps, now);
//     }

//     steps.value = totalSteps - lastResetSteps;
//     distance.value = steps.value * stepLength / 1000;

//     print('Step count: ${steps.value}, Distance: ${distance.value} km');
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     status.value = event.status;
//     print('Pedestrian status: ${status.value}');
//   }

//   void onPedestrianStatusError(error) {
//     print('Pedestrian Status Error: $error');
//     status.value = 'unknown';
//   }

//   void onStepCountError(error) {
//     print('Step Count Error: $error');
//     steps.value = 0;
//     distance.value = 0.0;
//   }

//   Future<void> initPlatformState() async {
//     try {
//       _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//       _stepCountStream = Pedometer.stepCountStream;

//       _stepCountStream.listen(onStepCount).onError(onStepCountError);
//       _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

//       print('Streams initialized');
//     } catch (e) {
//       print('Error initializing platform state: $e');
//     }
//   }

//   Future<void> loadLastReset() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     lastResetSteps = prefs.getInt('lastResetSteps') ?? 0;
//     lastResetTime = DateTime.tryParse(prefs.getString('lastResetTime') ?? '') ?? DateTime.now().subtract(Duration(hours: 24));
//     print('Last reset steps: $lastResetSteps, Last reset time: $lastResetTime');
//   }

//   Future<void> saveLastReset() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('lastResetSteps', lastResetSteps);
//     await prefs.setString('lastResetTime', lastResetTime.toIso8601String());
//     print('Saved last reset steps and time');
//   }

//   void resetSteps(int currentSteps, DateTime now) {
//     lastResetSteps = currentSteps;
//     lastResetTime = now;
//     saveLastReset();
//   }

//   Future<void> fetchStepGoals() async {
//     try {
//       stepGoals.value = await apiService.fetchStepGoals();
//       print('Step goals fetched: ${stepGoals.value}');
//     } catch (e) {
//       print('Error fetching step goals: $e');
//     }
//   }

//   Future<void> setDailyStepGoal(int stepGoal) async {
//     try {
//       bool success = await apiService.postStepGoal(stepGoal);
//       if (success) {
//         dailyStepGoal.value = stepGoal;
//         saveDailyStepGoal(stepGoal);
//         print('New daily step goal set: $stepGoal');
//       }
//     } catch (e) {
//       print('Error setting daily step goal: $e');
//     }
//   }

//   Future<void> saveDailyStepGoal(int stepGoal) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('dailyStepGoal', stepGoal);
//     print('Daily step goal saved: $stepGoal');
//   }

//   Future<void> loadDailyStepGoal() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     dailyStepGoal.value = prefs.getInt('dailyStepGoal') ?? 5000;
//     print('Loaded daily step goal: ${dailyStepGoal.value}');
//   }

//   void startDailyPostTimer() {
//     print('Starting daily post timer');
//     DateTime now = DateTime.now();
//     DateTime nextPostTime = DateTime(now.year, now.month, now.day, 12);
//     if (now.isAfter(nextPostTime)) {
//       nextPostTime = nextPostTime.add(Duration(days: 1));
//     }
//     Duration initialDelay = nextPostTime.difference(now);

//     _timer = RestartableTimer(initialDelay, () {
//       postDailySteps();
//       _timer = RestartableTimer(Duration(hours: 24), postDailySteps);
//     });
//   }

//   Future<void> postDailySteps() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('auth_token');
//       if (token != null) {
//         bool success = await apiService.postSteps(steps.value, token);
//         if (success) {
//           print('Steps posted successfully');
//           resetStepsAfterPost();
//         } else {
//           print('Failed to post steps');
//         }
//       } else {
//         print('Token not found');
//       }
//     } catch (e) {
//       print('Error posting steps: $e');
//     }
//   }

//   void resetStepsAfterPost() {
//     steps.value = 0;
//     distance.value = 0.0;
//     lastResetSteps = 0;
//     saveLastReset();
//     print('Steps reset after posting');
//   }
// }
