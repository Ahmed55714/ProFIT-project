import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/General/custom_back_button.dart';
import '../../../../widgets/StepProgress/Height/custom_hight_picker.dart';
import '../../Controller/basic_information.dart';

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
        const CustomStyledText(
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
              widget.onSelect();
            },
          ),
        )
      ],
    );
  }
}