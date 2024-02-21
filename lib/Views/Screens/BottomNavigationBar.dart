import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../pages/Home/HomeScreens/Diet.dart';
import '../pages/Home/HomeScreens/Explore.dart';
import '../pages/Home/HomeScreens/Home.dart';
import '../pages/Home/HomeScreens/More.dart';
import '../pages/Home/HomeScreens/Workout.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

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
          DietScreen(),
          WorkoutScreen(),
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
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: indicatorLeftPadding,
              child: Container(
                width: 42,
                height: 4,
                decoration: const BoxDecoration(
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
