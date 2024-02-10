import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showBackground; // Add this line

  const CustomBackButton({
    Key? key,
    required this.onPressed,
    this.showBackground = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: showBackground ? backGround : Colors.transparent, // Use the flag here
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed, // Simplified
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/svgs/back.svg',
                width: 10,
                height: 12,
              ),
            ),
          ),
        ],
      ), 
    );
  }
}


class CustomStyledText extends StatelessWidget {
  final String firstText;
  final String emphasizedText;
  final String lastText;

  const CustomStyledText({
    Key? key,
    this.firstText = 'What is your',
    this.emphasizedText = ' Gender',
    this.lastText = ' ?',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w400,
              color: Colors.black, 
              fontFamily: 'Cairo',
            ),
            children: <TextSpan>[
              TextSpan(
                text: firstText,
                style: TextStyle(color: colorDarkBlue),
              ),
              TextSpan(
                text: emphasizedText,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BoldCairo',
                  color: colorBlue,
                ),
              ),
              TextSpan(
                text: lastText,
                style: TextStyle(color: colorDarkBlue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
