import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Create%20Account/stepProgress.dart';
import 'package:profit1/utils/colors.dart';

import '../../../controllers/signup_controller.dart';
import '../../widgets/customBotton.dart';
import '../../widgets/custom_back_button.dart';
import 'confirm_password.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen(
      {super.key, required this.email, required this.role});
  final String email;
  final String role;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  final UserController userController = Get.find<UserController>();
  late Timer _timer;

  int _start = 56;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String getOtpFromControllers() {
    return otpControllers.map((c) => c.text).join();
  }

  void verifyOtp() async {
    final otp = getOtpFromControllers();
    final success = await userController.verifyOtp(widget.email, otp);
    if (success && widget.role == '0') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StepProgressScreen()));
    } else if (success && widget.role == '1') {
     Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ConfirmPasswordScreen()));
    }else{
      Get.snackbar('Error', 'OTP verification failed Please Check your internet connection');
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Header(
                        title1: 'Email Verification',
                        title2: 'Enter the 4-digits code we’ve sent to '),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'BoldCairo',
                        fontWeight: FontWeight.w700,
                        color: colorBlue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const CustomImageWidget(
                        imagePath: 'assets/images/3diconss.png'),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Request code again in ",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: colorDarkBlue,
                          ),
                        ),
                        Text(
                          "00:$_start",
                          style: const TextStyle(
                            fontFamily: 'BoldCairo',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colorBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                     VerificationCodeInput(controllers: otpControllers),
                    const SizedBox(height: 203),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Don’t received link? ",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: colorDarkBlue,
                                ),
                              ),
                              TextSpan(
                                text: "Resend",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      colorBlue, // Make sure this color is defined in your colors utility file
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              CustomButton(
                text: 'Verify Account',
                onPressed: 
                  verifyOtp,
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ConfirmPasswordScreen(),
                  //   ),
                  // );
                
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String text;
  final String secondText;
  final String email;

  TitleWidget(
      {Key? key,
      required this.text,
      required this.secondText,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "$secondText\n $email",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class VerificationCodeInput extends StatelessWidget {
    final List<TextEditingController> controllers;
  const VerificationCodeInput({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          4,
          (index) =>  SizedBox(
            height: 56,
            width: 56,
            child: VerificationCodeFormField(controller: controllers[index]),
          ),
        ),
      ),
    );
  }
}

class VerificationCodeFormField extends StatefulWidget {
    final TextEditingController controller;
  const VerificationCodeFormField({
    Key? key, required this.controller,
  }) : super(key: key);

  @override
  _VerificationCodeFormFieldState createState() =>
      _VerificationCodeFormFieldState();
}

class _VerificationCodeFormFieldState extends State<VerificationCodeFormField> {
  Color backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {    
        setState(() {
          backgroundColor = Colors.white;
        });
        if (value.length == 1 && value.isNotEmpty) {
          FocusScope.of(context).nextFocus();
          setState(() {
            backgroundColor = lightBlue;
          });
        }
      },
      onFieldSubmitted: (value) {
        setState(() {
          backgroundColor = Colors.white;
        });
      },
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFamily: 'BoldCairo',
        color: colorBlue,
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 7),
        hintStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'BoldCairo',
          color: colorBlue,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 2, color: colorBlue),
        ),
      ),
    );
  }
}
