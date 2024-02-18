// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool showBackground;
  const CustomBackButton({
    Key? key,
    required this.onPressed,
    this.showBackground = true, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: showBackground
            ? backGround
            : Colors.transparent, 
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onPressed, // Simplified
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/svgs/back.svg',
                  width: 10,
                  height: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// CREATION PROFILE QUESTIONS
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
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'Cairo',
            ),
            children: <TextSpan>[
              TextSpan(
                text: firstText,
                style: const TextStyle(color: colorDarkBlue),
              ),
              TextSpan(
                text: emphasizedText,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BoldCairo',
                  color: colorBlue,
                ),
              ),
              TextSpan(
                text: lastText,
                style: const TextStyle(color: colorDarkBlue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// CUSTOM HEADER TITLE FOR SCREENS
class Header extends StatelessWidget {
  String title1;
  String title2;

   Header({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title1',
          style: const TextStyle(
            fontSize: 23,
            fontFamily: 'BoldCairo',
            fontWeight: FontWeight.w700,
            color: colorDarkBlue,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '$title2',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: colorDarkBlue,
          ),
        ),
      ],
    );
  }
}

//CUSTOM IMAGE FORGET PASSWORD
class CustomImageWidget extends StatelessWidget {
    final String imagePath;

  const CustomImageWidget({super.key, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
         
            borderRadius: BorderRadius.circular(8.0), 
          ),
          child: Center(
            child: Image.asset(
              imagePath, 
              width: 180, 
              height: 180,
              fit: BoxFit.cover, 
            ),
          ),
        ),
      ],
    );
  }
}

