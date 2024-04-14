import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/General/custom_back_button.dart';
import '../../../../widgets/StepProgress/weight/Weight Picker/custom_wieghts.dart';
import '../../Controller/basic_information.dart';

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
        const CustomStyledText(
          firstText: 'What is your',
          emphasizedText: ' Weight',
          lastText: ' ?',
        ),
        
        const SizedBox(height: 47),
        SizedBox(
            height: 585,
            width: 343,
            child: CustomWeightPicker(
              initialValue: 80,
              currentHeight: controller.height.value,
              onValueChanged: (double newWeight) {
                controller.setWeight(newWeight);
              },
            )),
      ],
    );
  }
}