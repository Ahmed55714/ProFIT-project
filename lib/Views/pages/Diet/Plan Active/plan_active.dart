import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:profit1/utils/colors.dart';
import '../../../../services/api_service.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/CircularIndicator/circular_indicator.dart';
import '../../../widgets/Diet/Diet_calinder.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../Diet Plan Overview/Meals/Breakfast.dart';
import '../Diet Plan Overview/Meals/dinner.dart';
import '../Diet Plan Overview/Meals/luanch.dart';
import '../Diet Plan Overview/Meals/snacks.dart';
import 'controller/plan_active.dart';

class PlanActiveScreen extends StatefulWidget {
  final String planId;
  final String startTime;
  const PlanActiveScreen({Key? key, required this.planId, required this.startTime}) : super(key: key);

  @override
  State<PlanActiveScreen> createState() => _PlanActiveScreenState();
}

class _PlanActiveScreenState extends State<PlanActiveScreen> with SingleTickerProviderStateMixin {
  late int currentMonth;
  late int currentYear;
  late DateTime startOfWeek;
  late DateTime endOfWeek;
  late DateTime selectedDate;

  late TabController _tabController;
  final DietPlanActiveController _planOverviewController = Get.put(DietPlanActiveController());
  final ApiService _apiService = ApiService();
  bool _isDataFetched = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Ensure startTime is not null or empty before parsing
    if (widget.startTime.isNotEmpty) {
      try {
        DateTime startDate = DateFormat('yyyy-MM-dd').parse(widget.startTime);
        selectedDate = startDate;
        currentMonth = startDate.month;
        currentYear = startDate.year;
        _setStartAndEndOfWeek(startDate);
      } catch (e) {
        // Handle parsing error
        print("Error parsing startTime: $e");
        _useCurrentDate();
      }
    } else {
      // Handle case where startTime is empty
      _useCurrentDate();
    }

    _fetchData();
  }

  void _useCurrentDate() {
    DateTime now = DateTime.now();
    selectedDate = now;
    currentMonth = now.month;
    currentYear = now.year;
    _setStartAndEndOfWeek(now);
  }

  Future<void> _fetchData() async {
    if (!_isDataFetched) {
      String? token = await _apiService.getToken();
      if (token != null && token.isNotEmpty) {
        await _planOverviewController.fetchActivePlanDetails(widget.planId);
        setState(() {
          _isDataFetched = true;
        });
      } else {
        print("Token not found or is empty");
      }
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
    final selectedDate = DateTime(currentYear, currentMonth, day);
    setState(() {
      this.selectedDate = selectedDate;
      _setStartAndEndOfWeek(selectedDate);
    });
  }

  void _setStartAndEndOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    setState(() {
      this.startOfWeek = startOfWeek;
      this.endOfWeek = endOfWeek;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: colorBlue,
              onPrimary: Colors.white,
              surface: colorBlue,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        currentYear = pickedDate.year;
        currentMonth = pickedDate.month;
        _setStartAndEndOfWeek(pickedDate);
      });
    }
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
      body: Obx(() {
        if (_planOverviewController.isLoading.value) {
          return Center(child: CustomLoder());
        }

        final planDetails = _planOverviewController.activePlanDetails.value;
        final dailyMacros = planDetails?.planMacros;
        final eatenMacros = planDetails?.eatenDaysMacros;

        // Define upper limits for the progress bars


        return Column(
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
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
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
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Row(
                      key: ValueKey<int>(currentMonth),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(7, (index) {
                        final date = startOfWeek.add(Duration(days: index));
                        final day = date.day;
                        final isFinishedDay = date.isBefore(DateTime.now());
                        final isSelectedDay = date.isAtSameMomentAs(selectedDate);
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _selectDay(day);
                              },
                              child: DayContainer(
                                day: DateFormat('E').format(date),
                                date: day.toString(),
                                backgroundColorNumber: blue700,
                                BackGroundContiner: isSelectedDay ? DArkBlue800 : colorBlue,
                                NumberColorBackGround: isSelectedDay
                                    ? Colors.white
                                    : isFinishedDay
                                        ? blue700
                                        : colorBlue,
                                colorDay: isSelectedDay ? colorBlue : Colors.white,
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CustomLabelWidget(
                        title: 'Daily Macros',
                      ),
                    ),
                    if (dailyMacros != null)
                    
                  
                    if (eatenMacros != null)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DietProgressWidget(
                                  iconAsset: 'assets/svgs/diett.svg',
                                  label: 'Proteins',
                                  progressText: '${eatenMacros.proteins.toStringAsFixed(0)}/${dailyMacros!.proteins.toStringAsFixed(0)} g',
                                  progressPercent: eatenMacros.proteins / dailyMacros.proteins,
                                ),
                                DietProgressWidget(
                                  iconAsset: 'assets/svgs/waterdrops.svg',
                                  label: 'Fats',
                                  progressText: '${eatenMacros.fats.toStringAsFixed(0)}/${dailyMacros.fats.toStringAsFixed(0)} g',
                                  progressPercent: eatenMacros.fats / dailyMacros.fats,
                                ),
                                DietProgressWidget(
                                  iconAsset: 'assets/svgs/break.svg',
                                  label: 'Carbs',
                                  progressText: '${eatenMacros.carbs.toStringAsFixed(0)}/${dailyMacros!.carbs.toStringAsFixed(0)} g',
                                  progressPercent: eatenMacros.carbs / dailyMacros!.carbs,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: CircularIndicatorWithIconAndText(
                              percentage: eatenMacros.calories / dailyMacros!.calories,
                              backgroundColor: grey200,
                              progressColor: blue700,
                              iconName: '',
                              isShowDiet: true,
                              total: '${eatenMacros.calories.toStringAsFixed(0)}',
                              kal: '/${dailyMacros.calories.toStringAsFixed(0)} Kcal',
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            CustomTabBar(
              tabController: _tabController,
              isDiet: true,
              isSitable: true,
              tabTexts: ['Breakfast', 'Lunch', 'Snack', 'Dinner'],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BreakFast(isExpanded: true, planId: widget.planId),
                  Lunch(isExpanded: true, planId: widget.planId),
                  Snack(isExpanded: true, planId: widget.planId),
                  Dinner(isExpanded: true, planId: widget.planId),
                ],
              ),
            ),
          ],
        );
      }),
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
