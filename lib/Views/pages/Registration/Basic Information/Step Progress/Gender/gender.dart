import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/General/custom_back_button.dart';
import '../../../../../widgets/General/svg_icon_button.dart';
import '../../Controller/basic_information.dart';
import '../stepProgress.dart';

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
        const CustomStyledText(
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

            controller.setGender('Male');
          },
          text: 'Male',
          isClicked: selectedGender == 'Male',
        ),
        const SizedBox(height: 12),
        SvgIconButton(
          svgIcon: 'assets/svgs/female.svg',
          onSelect: () {
            onSelectGender('Female');

            controller.setGender('Female');
          },
          text: 'Female',
          isClicked: selectedGender == 'Female',
        ),
      ],
    );
  }
}