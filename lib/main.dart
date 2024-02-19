import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profit1/Home/HomeScreens/Home.dart';

import 'Create Account/onBoarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp> {
    @override
  void initState() {
    super.initState();
 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, 
    statusBarIconBrightness: Brightness.dark, 
  ));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'ProFIT',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
      ),
      home: HomeScreen(),
      //const OnBoarding(),
    );
  }
}
