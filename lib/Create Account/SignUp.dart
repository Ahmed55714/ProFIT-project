import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/customBotton.dart';
import '../widgets/custom_back_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
           BackBlueButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
            'Create Account',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: colorDarkBlue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
            'Sign up to get started!',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // SignUpForm(),
          const SizedBox(
            height: 20,
          ),
          const TermsAndPrivacyText(),
        ],
      ),
    );
  }
}