import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/Tearms%20and%20privacy/Terms_and_privacy_text.dart';
import '../../../utils/colors.dart';
import '../../widgets/General/customBotton.dart';
import '../Registration/Sign Up/SignUp.dart'; 

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
          _buildBackgroundImage(),
          _buildBackgroundColorOverlay(),
          SafeArea(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0.2126, 0.7152, 0.0722, 0, 0,
        0,      0,      0,      1, 0,
      ]),
      child:  Image.asset(
        'assets/images/gym.jpeg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildBackgroundColorOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white.withOpacity(0.8),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: _buildLogoAndPoweredBy(),
        ),
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildLogoAndPoweredBy() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.asset(
            'assets/images/logo.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 16),
          _buildPoweredBy(),
        ],
      ),
    );
  }

  Widget _buildPoweredBy() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/svgs/shieldCross.svg",
          width: 14,
          height: 15,
        ),
        const SizedBox(width: 4),
         RichText(
          text: const TextSpan(
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
    );
  }

  Widget _buildBottomSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomButton(
          text: "Let's Start",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUp()),
          ),
        ),
        const SizedBox(height: 16),
        const TermsAndPrivacyText(),
        const SizedBox(height: 16),
      ],
    );
  }
}
