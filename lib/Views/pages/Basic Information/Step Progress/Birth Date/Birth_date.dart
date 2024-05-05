import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/General/custom_back_button.dart';
import '../../../../widgets/StepProgress/Birth Date/custom_date_picker.dart';
import '../../Controller/basic_information.dart';

class BirthDateSelection extends StatefulWidget {
  final VoidCallback onSelect;
  final Function(String?) onError; 

  BirthDateSelection({required this.onSelect, required this.onError});

  @override
  State<BirthDateSelection> createState() => _BirthDateSelectionState();
}

class _BirthDateSelectionState extends State<BirthDateSelection> {
  final StepProgressController controller = Get.put(StepProgressController());

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CustomStyledText(
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
            onError: widget.onError,
          ),
        ),
      ],
    );
  }
}
