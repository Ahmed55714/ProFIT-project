import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/basic_information.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/custom_back_button.dart';
import '../../Tabs/Tabs/Home.dart';
import 'Activity Level/activity_level.dart';
import 'Birth Date/Birth_date.dart';
import 'Fitness Goal/fitness_goal.dart';
import 'Gender/gender.dart';
import 'Height/Height.dart';
import 'Weight/weight.dart';

class StepProgressScreen extends StatefulWidget {
  @override
  _StepProgressScreenState createState() => _StepProgressScreenState();
}

class _StepProgressScreenState extends State<StepProgressScreen>
    with SingleTickerProviderStateMixin {
  Future<void> _markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
  }

  int selectedHeight = 180;
  String? _errorText;
  int currentStep = 1;
  int totalSteps = 6;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;
  String selectedGender = '';
  String? _errorMessage;

  void handleDatePickerError(String? message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: progressValue(),
    ).animate(_progressAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _progressAnimationController.forward();
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  double progressValue() => currentStep / totalSteps;

  void nextStep() {
    if (_errorMessage == null && currentStep < totalSteps) {
      setState(() => currentStep++);
      _animateProgress();
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() => currentStep--);
      _animateProgress();
    }
  }

  void _animateProgress() {
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: progressValue(),
    ).animate(CurvedAnimation(
      parent: _progressAnimationController,
      curve: Curves.easeInOut,
    ));

    _progressAnimationController
      ..reset()
      ..forward();
  }

  void selectGender(String gender) {
    setState(() {
      if (selectedGender == gender) {
        selectedGender = (gender == 'Male') ? 'Female' : 'Male';
      } else {
        selectedGender = gender;
      }
// selectedGender = gender;
    });
  }

  void handleNextStep() {
    if (currentStep < totalSteps && selectedGender.isNotEmpty) {
      nextStep();
    }
  }

  final StepProgressController controller = Get.put(StepProgressController());

  Widget stepContent() {
    switch (currentStep) {
      case 1:
        return GenderSelection(
          onSelectGender: selectGender,
          selectedGender: selectedGender,
        );

      case 2:
        return BirthDateSelection(
          onSelect: nextStep,
          onError: handleDatePickerError,
        );

      case 3:
        return HightSelection(
          onSelect: () {},
          onSelectHeight: (int height) {
            controller.setHeight(height);
          },
        );
      case 4:
        return const WeightKg();
      case 5:
        return const FitnesGoal();
      case 6:
        return const ActivityLevel();
      default:
        return Container();
    }
  }

  void skipAllSteps() async {
    controller.setGender('Male');
    controller.setBirthDate(DateTime.now());
    controller.setHeight(170);
    controller.setWeight(65.0);
    controller.setFitnessGoals('Maintain');
    controller.setActivityLevel('Moderately Active');

    // Completing the profile setup
    await controller.finishProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      onPressed: () {
                        if (currentStep == 1) {
                          Navigator.pop(context);
                        } else {
                          previousStep();
                        }
                      },
                      showBackground: false,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$currentStep/$totalSteps',
                      style: const TextStyle(
                          color: colorBlue, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 6.0,
                        percent: _progressAnimation.value,
                        backgroundColor: Colors.grey.shade300,
                        progressColor: colorBlue,
                        barRadius: const Radius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        skipAllSteps();
                      },
                      child: const Text('Skip',
                          style: TextStyle(
                              color: colorBlue, fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/svgs/right.svg',
                        width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 16),
                stepContent(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _errorMessage == null
          ? Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, bottom: 40),
              child: CustomButton(
                text: (currentStep == totalSteps) ? 'Finish' : 'Next',
                onPressed: () async {
                  if (currentStep == totalSteps) {
                    await controller.finishProfile();
                    _markOnboardingComplete().then((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    });
                  } else {
                    nextStep();
                  }
                },
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
