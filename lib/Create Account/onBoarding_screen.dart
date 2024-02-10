import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Assuming your colors.dart file exists and contains a definition for colorBlue
import '../utils/colors.dart';
import '../widgets/customBotton.dart';
import 'SignUp.dart'; // Ensure the path is correct

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: Image.asset(
              'assets/images/gym.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.8),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/shieldCross.svg",
                              width: 14,
                              height: 15,
                            ),
                            const SizedBox(width: 4),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Powered by ",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: colorBlue,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Alpha Team",
                                    style: TextStyle(
                                      fontFamily: 'BoldCairo',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: colorBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Align content at the bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Use min to take up least required space
                    children: [
                      CustomButton(
                        text: "Let's Start",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const TermsAndPrivacyText(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
