import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;

  const CustomTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: DArkBlue900,
          ),
        ),
      ],
    );
  }
}
