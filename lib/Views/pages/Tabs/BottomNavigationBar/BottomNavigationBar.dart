// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Workout/workout.dart';

import 'package:profit1/utils/colors.dart';

import '../../Diet/Plan Active/plan_active.dart';
import '../../Profile/Account Data/controller/profile_controller.dart';
import '../home/Home.dart';
import '../Diet/Diet.dart';
import '../Explore/Explore.dart';
import '../More/More.dart';
import '../WorkOut/Workout.dart';

class BottomNavigation extends StatefulWidget {
  int selectedIndex;
  String role;
  BottomNavigation({
    Key? key,
    required this.selectedIndex,
    required this.role,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final ProfileController profileController = Get.find<ProfileController>();

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    // Set initial index based on role
    switch (widget.role.toLowerCase()) {
      case 'diet':
        _selectedIndex = 2;
        break;
      case 'workout':
        _selectedIndex = 3;
        break;
      case 'explore':
        _selectedIndex = 1; 
        break;
      default:
        _selectedIndex = widget.selectedIndex;
        break;
    }

    profileController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth / 5;
    double indicatorLeftPadding =
        _selectedIndex * tabWidth + (tabWidth - 42) / 2;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          ExploreScreen(),
         PlanActiveScreen(),
        WorkOutSession(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: SvgPicture.asset('assets/svgs/home.svg',
                        color: colorDarkBlue),
                  ),
                  label: 'Home',
                  
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: SvgPicture.asset('assets/svgs/explore.svg',
                        color: colorDarkBlue),
                  ),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: SvgPicture.asset('assets/svgs/diet.svg',
                        color: colorDarkBlue),
                  ),
                  label: 'Diet',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: SvgPicture.asset('assets/svgs/workout.svg',
                        color: colorDarkBlue),
                  ),
                  label: 'Workout',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2.5),
                    child: SvgPicture.asset('assets/svgs/grid.svg',
                        color: colorDarkBlue),
                  ),
                  label: 'More',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: colorDarkBlue,
              unselectedItemColor: colorDarkBlue,
              selectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.bold,  fontFamily: 'Cairo',height: 1.2),
              unselectedLabelStyle:
                  TextStyle(fontSize: 10, fontWeight: FontWeight.normal,  fontFamily: 'Cairo',height: 1.2),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                if (index == 0) {
                  profileController.fetchUserProfile();
                }
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: indicatorLeftPadding,
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: colorBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
