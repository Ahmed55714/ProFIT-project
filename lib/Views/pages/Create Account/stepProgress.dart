import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../controllers/user_fitness_profile.dart';
import '../../../utils/colors.dart';
import '../../widgets/General/customBotton.dart';
import '../../widgets/General/custom_back_button.dart';
import '../../widgets/StepProgress/custom_activitylevel.dart';
import '../../widgets/StepProgress/custom_date_picker.dart';
import '../../widgets/StepProgress/custom_hight_picker.dart';
import '../../widgets/StepProgress/custom_wieghts.dart';

import '../../widgets/StepProgress/fitness_Goal.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';

class StepProgressScreen extends StatefulWidget {
  @override
  _StepProgressScreenState createState() => _StepProgressScreenState();
}

class _StepProgressScreenState extends State<StepProgressScreen>
    with SingleTickerProviderStateMixin {
  int currentStep = 1;
  int totalSteps = 6;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;
  String selectedGender = '';

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
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
    if (currentStep < totalSteps) {
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
        return BirthDateSelection(onSelect: nextStep);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
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
                      SizedBox(width: 8),
                      Text(
                        '$currentStep/$totalSteps',
                        style: TextStyle(
                            color: colorBlue, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 6.0,
                          percent: _progressAnimation.value,
                          backgroundColor: Colors.grey.shade300,
                          progressColor: colorBlue,
                          barRadius: const Radius.circular(10),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          nextStep();
                        },
                        child: Text('Skip',
                            style: TextStyle(
                                color: colorBlue, fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(width: 8),
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 40),
          child: CustomButton(
            text: (currentStep == totalSteps) ? 'Finish' : 'Next',
            onPressed: () async {
              if (currentStep == totalSteps) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation(
                              selectedIndex: 0,
                              role: 'Home',
                        )));
              } else {
                nextStep();
              }
            },
          ),
        ));
  }
}

class GenderSelection extends StatelessWidget {
  final Function onSelectGender;
  final String selectedGender;

  GenderSelection({
    required this.onSelectGender,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    final StepProgressController controller = Get.put(StepProgressController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Gender',
          lastText: ' ?',
        ),
        const SizedBox(height: 126.5),
        SvgIconButton(
          svgIcon: 'assets/svgs/male.svg',
          onSelect: () {
            // Toggle gender selection visually
            onSelectGender('Male');
            // Update the controller's state
            controller.setGender('Male');
          },
          text: 'Male',
          isClicked: selectedGender == 'Male',
        ),
        const SizedBox(height: 12),
        SvgIconButton(
          svgIcon: 'assets/svgs/female.svg',
          onSelect: () {
            // Toggle gender selection visually
            onSelectGender('Female');
            // Update the controller's state
            controller.setGender('Female');
          },
          text: 'Female',
          isClicked: selectedGender == 'Female',
        ),
      ],
    );
  }
}

class BirthDateSelection extends StatefulWidget {
  final VoidCallback onSelect;

  BirthDateSelection({required this.onSelect});

  @override
  State<BirthDateSelection> createState() => _BirthDateSelectionState();
}

class _BirthDateSelectionState extends State<BirthDateSelection> {
  final StepProgressController controller = Get.put(StepProgressController());

  DateTime selectedDate = DateTime.now();
  double selectedWeight = 70.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Birth Date',
          lastText: ' ?',
        ),
        const SizedBox(height: 150),
        SizedBox(
          height: 200,
          child: CustomDatePicker(
            onDateChanged: (DateTime newDate) {
              controller.setBirthDate(newDate);
            },
          ),
        ),
      ],
    );
  }
}

class HightSelection extends StatefulWidget {
  final VoidCallback onSelect;
  final Function(int) onSelectHeight;
  HightSelection({required this.onSelect, required this.onSelectHeight});

  @override
  State<HightSelection> createState() => _HightSelectionState();
}

class _HightSelectionState extends State<HightSelection> {
  final StepProgressController controller = Get.put(StepProgressController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Height',
          lastText: ' ?',
        ),
        const SizedBox(height: 73),
        SizedBox(
          height: 500,
          child: CustomHeightPicker(
            onSelectHeight: (int height) {
              controller.setHeight(height);
            },
          ),
        )
      ],
    );
  }
}

class WeightKg extends StatefulWidget {
  const WeightKg({super.key});

  @override
  State<WeightKg> createState() => _WeightKgState();
}

class _WeightKgState extends State<WeightKg> {
  @override
  Widget build(BuildContext context) {
    final StepProgressController controller =
        Get.find<StepProgressController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Weight',
          lastText: ' ?',
        ),
        const SizedBox(height: 47),
        SizedBox(
            height: 585,
            width: 343,
            child: CustomWeightPicker(
              initialValue: 70,
              onValueChanged: (double newWeight) {
                controller.setWeight(newWeight);
              },
            )),
      ],
    );
  }
}

class FitnesGoal extends StatefulWidget {
  const FitnesGoal({super.key});

  @override
  State<FitnesGoal> createState() => _FitnesGoalState();
}

class _FitnesGoalState extends State<FitnesGoal> {
  int selectedContainerIndex = -1;

  void selectContainer(int index) {
    setState(() {
      selectedContainerIndex = (selectedContainerIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final StepProgressController controller = Get.put(StepProgressController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Fitness Goal',
          lastText: ' ?',
        ),
        const SizedBox(height: 131),
        SizedBox(
          height: 80,
          child: CustomSelectionStepProgress(
            index: 0,
            svgAsset: 'assets/svgs/flame.svg',
            isSelected: selectedContainerIndex == 0,
            title: "Lose Weight",
            description: "Loss weight and improve my fitness",
            onTap: () {
              selectContainer(0);
              controller.setFitnessGoals("Lose Weight");
            },
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: CustomSelectionStepProgress(
            index: 1,
            svgAsset: 'assets/svgs/Bicep.svg',
            isSelected: selectedContainerIndex == 1,
            title: "Build Muscle",
            description: "Increase muscle mass",
            onTap: () {
              selectContainer(1);
              controller.setFitnessGoals("Build Muscle");
            },
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: CustomSelectionStepProgress(
            index: 2,
            svgAsset: 'assets/svgs/apple.svg',
            isSelected: selectedContainerIndex == 2,
            title: "Healthy Lifestyle",
            description: "have a healthy lifetsyle",
            onTap: () {
              selectContainer(2);
              controller.setFitnessGoals("Healthy Lifestyle");
            },
          ),
        ),
      ],
    );
  }
}

class ActivityLevel extends StatefulWidget {
  const ActivityLevel({super.key});

  @override
  State<ActivityLevel> createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {
  final StepProgressController controller = Get.put(StepProgressController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Activity Level',
          lastText: ' ?',
        ),
        SizedBox(height: 56),
        SizedBox(
          height: 550,
          width: 250,
          child: ActivityLevell(
            onActivityLevelChanged: (String newActivityLevel) {
              controller.setActivityLevel(newActivityLevel);
            },
          ),
        ),
      ],
    );
  }
}

class SvgIconButton extends StatefulWidget {
  final String svgIcon;
  final VoidCallback onSelect;
  final String text;
  final bool isClicked;

  SvgIconButton({
    required this.svgIcon,
    required this.onSelect,
    required this.text,
    required this.isClicked,
  });

  @override
  _SvgIconButtonState createState() => _SvgIconButtonState();
}

class _SvgIconButtonState extends State<SvgIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: widget.isClicked ? backGround : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.svgIcon,
              color: widget.isClicked ? colorBlue : colorBlue,
              width: 56,
              height: 56,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BoldCairo',
                  color: widget.isClicked ? colorBlue : colorBlue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
