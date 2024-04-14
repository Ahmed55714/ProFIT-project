import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

class CustomRulerIndicator extends StatelessWidget {
  final int value;
  final bool isCentered;
  final ValueChanged<double> onValueChanged;

  const CustomRulerIndicator({
    Key? key,
    required this.value,
    required this.isCentered,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta != null && details.primaryDelta!.abs() > 0) {
            onValueChanged(value.toDouble());
          }
        },
        child: Container(
          width: 2.82,
          height: heightForValue(value),
          color: colorBlue,
        ),
      ),
    );
  }

  double heightForValue(int value) {
    if (value % 10 == 0) {
      return 90; 
    } else if (value % 5 == 0) {
      return 59;
    } else {
      return 29;  
    }
  }
}
