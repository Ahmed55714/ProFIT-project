import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/pages/Onboarding/onBoarding_screen.dart';

import 'Views/pages/Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import 'Views/pages/Profile/Account Data/controller/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth_token');
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  Get.put(ProfileController());
  runApp(MyApp(
    isLoggedIn: token != null && onboardingComplete,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProFIT',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Cairo',
      ),
      home: isLoggedIn
          ? BottomNavigation(role: 'Home', selectedIndex: 0)
          : OnBoarding(),
    );
  }
}
