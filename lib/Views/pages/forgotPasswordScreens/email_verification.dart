import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Basic%20Information/Step%20Progress/stepProgress.dart';
import 'package:profit1/utils/colors.dart';

import '../Registration/controller/auth_controller.dart';

import '../../widgets/General/customBotton.dart';
import '../../widgets/General/custom_back_button.dart';
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
  Timer? _timer;
  bool isVerifying = false;

  int _start = 56;
  final int _initialStart = 56;

  void resetAndStartTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _start = _initialStart;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    resetAndStartTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  String getOtpFromControllers() {
    return otpControllers.map((c) => c.text).join();
  }

void verifyOtp() async {
  // Check if all OTP fields are filled
  bool allFilled = otpControllers.every((controller) => controller.text.isNotEmpty);

  if (!allFilled) {
    Get.snackbar('Error', 'Please fill all fields before verifying.');
    return; // Stop execution if not all fields are filled
  }

  setState(() {
    isVerifying = true;
  });

  String otp = getOtpFromControllers();

  try {
    if (widget.role == '0') {
      bool success = await userController.verifyOtp(widget.email, otp);
      if (success) {
       Get.to(StepProgressScreen());
      } else {
        Get.snackbar('Error', 'Failed to verify OTP');
      }
    } else if (widget.role == '1') {
      Get.to(ConfirmPasswordScreen(otp: otp));
    }
  } finally {
    if (mounted) {
      setState(() {
        isVerifying = false; // Stop verifying
      });
    }
  }
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
                      Navigator.pop(context, 'fromVerification');
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
                 VerificationCodeInput(
  controllers: otpControllers,
  onCompleted: verifyOtp, // This function will be called when the last OTP field's "Done" button is pressed
)
,
                    const SizedBox(height: 203),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await userController.resendOtp(widget.email);
                            resetAndStartTimer();
                          },
                          child: RichText(
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
                                    color: colorBlue,
                                  ),
                                ),
                              ],
                            ),
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
                onPressed: isVerifying
                    ? null
                    : () {
                        verifyOtp();
                      },
                isLoading: isVerifying,
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
  final VoidCallback onCompleted;

  const VerificationCodeInput({
    Key? key,
    required this.controllers,
    required this.onCompleted, // Passing the function that will be called on completion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          4,
          (index) => SizedBox(
            height: 56,
            width: 56,
            child: VerificationCodeFormField(
              controller: controllers[index],
              onCompleted: index == 3 ? onCompleted : null, // Only pass this on the last OTP field
            ),
          ),
        ),
      ),
    );
  }
}




























class VerificationCodeFormField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onCompleted; // Optional callback for when the field is submitted

  const VerificationCodeFormField({
    Key? key,
    required this.controller,
    this.onCompleted,
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
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        }
        setState(() {
          backgroundColor = value.isEmpty ? Colors.transparent : lightBlue;
        });
      },
      onFieldSubmitted: (value) {
        if (widget.onCompleted != null && value.isNotEmpty) {
          widget.onCompleted!(); // Trigger the completion callback if provided
        }
      },
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFamily: 'BoldCairo',
        color: colorBlue,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 7),
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
