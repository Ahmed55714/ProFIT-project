import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../utils/colors.dart';
import '../../widgets/Animation/AnimationPage.dart';
import '../../widgets/AppBar/custom_appbar.dart';
import '../../widgets/Diet/Diet_calinder.dart';
import '../../widgets/Workout/custom_workout_card.dart';
import '../Diet/Plan Active/plan_active.dart';
import 'start_workout.dart';

class WorkOutSession extends StatefulWidget {
  const WorkOutSession({super.key});

  @override
  State<WorkOutSession> createState() => _WorkOutSessionState();
}

class _WorkOutSessionState extends State<WorkOutSession> {
  late int currentMonth;
  late int currentYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    currentMonth = now.month;
    currentYear = now.year;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        titleText: 'Workout',
        showContainer: true,
        isShowNormal: true,
        isShowActiveWorkout: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                              'assets/svgs/chevron-small-lefttt.svg'),
                        ),
                        const SizedBox(width: 24),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: '',
                                //${getMonthName(currentMonth)}, 
                                style: TextStyle(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Mon',
                        date: '1',
                        backgroundColorNumber: blue700,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Tue',
                        date: '2',
                        backgroundColorNumber: blue700,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Wed',
                        date: '3',
                        backgroundColorNumber: blue700,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Thr',
                        date: '4',
                        BackGroundContiner: DArkBlue800,
                        backgroundColorNumber: blue700,
                        NumberColorBackGround: Colors.white,
                        colorDay: colorBlue,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Fri',
                        date: '5',
                        backgroundColorNumber: blue700,
                        NumberColorBackGround: colorBlue,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Sat',
                        date: '6',
                        backgroundColorNumber: blue700,
                        NumberColorBackGround: colorBlue,
                      ),
                      SizedBox(width: 8),
                      DayContainer(
                        day: 'Sun',
                        date: '7',
                        backgroundColorNumber: blue700,
                        NumberColorBackGround: colorBlue,
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Start Workout Session',
              onPressed: () {
                Navigator.of(context).push(createRoute(const StartWorkout()));
              },
            ),
            const CustomLabelWidget(
              title: 'Warmup',
            ),
            const CustomWorkoutCard(
              exerciseName: 'Jumping Jacks',
              exerciseImage: 'assets/images/work.png',
            ),
            const CustomLabelWidget(
              title: 'Primary Workout',
            ),
            const CustomWorkoutCard(
              exerciseName: 'Pushups',
              exerciseImage: 'assets/images/work.png',
            ),
          ],
        ),
      ),
    );
  }
}
