import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/General/custom_back_button.dart';
import '../../../../widgets/StepProgress/Activity Level/custom_activitylevel.dart';
import '../../Controller/basic_information.dart';

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
        const CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Activity Level',
          lastText: ' ?',
        ),
        const SizedBox(height: 56),
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