import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBlue,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            height: 1.26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "By using Our services agreeing to ",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
          TextSpan(
            text: "Terms ",
            style: TextStyle(
              fontFamily: 'BoldCairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
          TextSpan(
            text: "and ",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              fontFamily: 'BoldCairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
