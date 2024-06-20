import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Diet/Diet_calinder.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../../widgets/CircularIndicator/circular_indicator.dart';
import '../Diet Plan Overview/Meals/Breakfast.dart';
import 'controller/plan_active.dart';
import '../../../../../services/api_service.dart';

class PlanActiveScreen extends StatefulWidget {
  const PlanActiveScreen({super.key});

  @override
  State<PlanActiveScreen> createState() => _PlanActiveScreenState();
}

class _PlanActiveScreenState extends State<PlanActiveScreen>
    with SingleTickerProviderStateMixin {
  late int currentMonth;
  late int currentYear;
  int selectedDay = 4;

  late TabController _tabController;
  late ActivePlanController _activePlanController;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _activePlanController = Get.put(ActivePlanController());
    final now = DateTime.now();
    currentMonth = now.month;
    currentYear = now.year;
    _fetchData();
  }

  void _fetchData() async {
    String? token = await _apiService.getToken();
    if (token != null && token.isNotEmpty) {
    //  _activePlanController.fetchDietPlans(token);
    } else {
      // Handle token not found scenario
      print("Token not found or is empty");
      // Optionally, navigate to a login screen or show a message to the user
    }
  }

  void _changeMonth(int monthOffset) {
    setState(() {
      currentMonth += monthOffset;
      if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
      } else if (currentMonth < 1) {
        currentMonth = 12;
        currentYear--;
      }
    });
  }

  void _selectDay(int day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Diet',
        showContainer: true,
        isShowNormal: true,
        isShowActiveDiet: true,
      ),
      body: Column(
        children: [
          Container(
            height: 125,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: colorBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _changeMonth(-1);
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-lefttt.svg',
                        ),
                      ),
                      const SizedBox(width: 24),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${getMonthName(currentMonth)}, ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: '$currentYear',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          _changeMonth(1);
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-right.svg',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: Row(
                    key: ValueKey<int>(currentMonth),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(7, (index) {
                      int day = index + 1;
                      bool isFinishedDay = day < selectedDay;
                      bool isSelectedDay = day == selectedDay;
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectDay(day);
                            },
                            child: DayContainer(
                              day: DateFormat('E').format(
                                  DateTime(currentYear, currentMonth, day)),
                              date: day.toString(),
                              backgroundColorNumber: blue700,
                              BackGroundContiner:
                                  isSelectedDay ? DArkBlue800 : colorBlue,
                              NumberColorBackGround: isSelectedDay
                                  ? Colors.white
                                  : isFinishedDay
                                      ? blue700
                                      : colorBlue,
                              colorDay:
                                  isSelectedDay ? colorBlue : Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: grey200,
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: CustomLabelWidget(
                      title: 'Daily Macros',
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            DietProgressWidget(
                              iconAsset: 'assets/svgs/diett.svg',
                              label: 'Proteins',
                              progressText: '80 / 134 g',
                              progressPercent: 0.7,
                            ),
                            DietProgressWidget(
                              iconAsset: 'assets/svgs/waterdrops.svg',
                              label: 'Fats',
                              progressText: '80 / 134 g',
                              progressPercent: 0.3,
                            ),
                            DietProgressWidget(
                              iconAsset: 'assets/svgs/break.svg',
                              label: 'Carbs',
                              progressText: '80 / 134 g',
                              progressPercent: 0.5,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: CircularIndicatorWithIconAndText(
                          percentage: 0.5,
                          backgroundColor: grey200,
                          progressColor: blue700,
                          iconName: '',
                          isShowDiet: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          CustomTabBar(
            tabController: _tabController,
            isDiet: true,
            isSitable :true,
            tabTexts: ['Breakfast', 'Lunch', 'Snack', 'Dinner'],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: BreakFast(
                    isExpanded: true,
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('Lunch Content'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('Snack Content'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('Dinner Content'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
