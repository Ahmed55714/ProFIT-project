import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/pages/Workout/workout.dart';

import '../../../../utils/colors.dart';
import '../../../pages/BottomNavigationBar/Tabs/BottomNavigationBar.dart';
import '../../General/customBotton.dart';
import 'free_diet.dart';
import 'trainer_continer.dart';

class FreeWorkout extends StatefulWidget {
  const FreeWorkout({Key? key}) : super(key: key);

  @override
  State<FreeWorkout> createState() => _FreeWorkoutState();
}

class _FreeWorkoutState extends State<FreeWorkout> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigation(
                selectedIndex: 3,
                role: 'workout',
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: grey200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/Dumbbell.svg',
                        ),
                        const CustomLabelWidget(
                          title: 'Push-Pull-Leg',
                          isChangeColor: true,
                          isPadding: true,
                        ),
                        CustomBadge(text: 'Intermediate'),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: RatingWidget(),
                    ),
                    const SizedBox(height: 16),
                    CustomTextWidget(
                      text:
                          'This plan is designed to help you reach your fitness goals, whether you\'re just starting out or looking for a new challenge.',
                      color: colorDarkBlue,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: grey50,
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: ExperienceWidget(
                              svg: 'assets/svgs/calendar.svg',
                              isShowSvg: true,
                              text: 'Duration: ',
                              text2: '7 Days',
                            ),
                          ),
                          Expanded(
                            child: ExperienceWidget(
                              svg: 'assets/svgs/location-1.svg',
                              isShowSvg: true,
                              text: 'Location: ',
                              text2: 'Gym',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    const Divider(color: grey200, thickness: 1),
                    SizedBox(height: 8),
                    const CreatedByCard()
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: isLoved
                      ? SvgPicture.asset('assets/svgs/love1.svg')
                      : SvgPicture.asset('assets/svgs/love.svg'),
                  onPressed: () {
                    setState(() {
                      isLoved = !isLoved;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
