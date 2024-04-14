import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/General/custom_back_button.dart';
import '../../../../widgets/StepProgress/Fitness Goal/fitness_Goal.dart';
import '../../Controller/basic_information.dart';

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
        const CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Fitness Goal',
          lastText: ' ?',
        ),
        const SizedBox(height: 131),
        SizedBox(
          height: 80,
          child: CustomSelectionStepProgress(
            index: 0,
            svgAsset: 'assets/svgs/Flame.svg',
            isSelected: selectedContainerIndex == 0,
            title: "Lose Weight",
            description: "Loss weight and improve my fitness",
            onTap: () {
              selectContainer(0);
              controller.setFitnessGoals("Lose Weight");
            },
          ),
        ),
        const SizedBox(height: 8),
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
        const SizedBox(height: 8),
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