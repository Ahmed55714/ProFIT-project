import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/pages/BottomNavigationBar/Tabs/Explore.dart';
import 'Views/pages/BottomNavigationBar/Tabs/Home.dart';
import 'Views/pages/Create Account/onBoarding_screen.dart';
import 'Views/pages/Create Account/stepProgress.dart';
import 'Views/pages/Explore/Package/check_out.dart';
import 'utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
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
      home: _isLoggedIn ? StepProgressScreen() : OnBoarding(),
    );
  }
}