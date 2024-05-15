import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

import 'Views/pages/Onboarding/onBoarding_screen.dart';
import 'Views/pages/Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import 'Views/pages/Profile/Account Data/controller/profile_controller.dart';
import 'services/api_service.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {}

  // Shared preferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  // GetX
  Get.put(ApiService());
  Get.put(ProfileController());

  runApp(MyApp(
    isLoggedIn: token != null && onboardingComplete,
    cameras: cameras,
  ));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.isLoggedIn, required this.cameras})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      
    ));
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProFIT',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
      ),
      home: widget.isLoggedIn
          ? BottomNavigation(role: 'Home', selectedIndex: 0)
          : OnBoarding(),
      //  MoreScreen(),
    );
  }
}
