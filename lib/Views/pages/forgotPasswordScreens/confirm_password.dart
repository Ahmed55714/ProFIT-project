// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:profit1/utils/colors.dart';

import '../../../services/api_service.dart';
import '../../widgets/General/customBotton.dart';
import '../../widgets/General/customTextFeild.dart';
import '../../widgets/General/custom_back_button.dart';
import '../Registration/Sign In/SignIn.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  String otp;
  ConfirmPasswordScreen({
    Key? key,
    required this.otp,
  }) : super(key: key);

  @override
  State<ConfirmPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ConfirmPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordSpecialCharacter = false;
  bool _isButtonEnabled = false;
  bool _isPasswordUpperLetter = false;
  bool _isPAsswordLowerLetter = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to both password controllers
    _passwordController1.addListener(() => onPasswordChanged());
    _passwordController2.addListener(() => onPasswordChanged());
  }

  void onPasswordChanged() {
    final password1 = _passwordController1.text;
    final password2 = _passwordController2.text;

    setState(() {
      _isPasswordEightCharacters = password1.length >= 8;
      _hasPasswordOneNumber = RegExp(r'[0-9]').hasMatch(password1);
      _hasPasswordSpecialCharacter =
          RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password1);
      _isPasswordUpperLetter = RegExp(r'[A-Z]').hasMatch(password1);
      _isPAsswordLowerLetter = RegExp(r'[a-z]').hasMatch(password1);

      _updateButtonState();
    });
  }

  void _updateButtonState() {
    final passwordsMatch =
        _passwordController1.text == _passwordController2.text;
    final isNotEmpty = _passwordController1.text.isNotEmpty &&
        _passwordController2.text.isNotEmpty &&
        passwordsMatch &&
        _isPasswordEightCharacters &&
        _hasPasswordOneNumber &&
        _hasPasswordSpecialCharacter;

    setState(() {
      _isButtonEnabled = isNotEmpty;
    });
  }

  int getValidationProgress() {
    int progress = 0;
    if (_isPasswordEightCharacters &&
        _isPasswordUpperLetter &&
        _isPAsswordLowerLetter) progress++;
    if (_hasPasswordOneNumber) progress++;
    if (_hasPasswordSpecialCharacter) progress++;
    return progress;
  }

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      _resetPassword();
    }
  }

  void _resetPassword() async {
    bool isReset = await ApiService().resetPassword(
      widget.otp,
      _passwordController1.text,
      _passwordController2.text,
    );
    if (isReset) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reset the password')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController1.dispose();
    _passwordController2.dispose();
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Header(
                            title1: 'New Password',
                            title2:
                                'Enter your new password and don’t forget it'),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomImageWidget(
                          imagePath: 'assets/images/3diconsss.png',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          name: 'New Password',
                          labelText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          showClearIcon: false,
                          fieldHeight: 56,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 12, bottom: 12, right: 4),
                            child: SvgPicture.asset('assets/svgs/password.svg'),
                          ),
                          controller: _passwordController1,
                          isPasswordField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!_isPasswordEightCharacters) {
                              return 'Password must be at least 8 characters';
                            }
                            if (!_hasPasswordOneNumber) {
                              return 'Password must contain at least one number';
                            }
                            if (!_hasPasswordSpecialCharacter) {
                              return 'Password must contain at least one special character';
                            }
                            if (!_isPasswordUpperLetter) {
                              return 'Password must contain at least one uppercase letter';
                            }
                            if (!_isPAsswordLowerLetter) {
                              return 'Password must contain at least one lowercase letter';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          name: 'Confirm New Password',
                          labelText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          showClearIcon: false,
                          fieldHeight: 56,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 12, bottom: 12, right: 4),
                            child: SvgPicture.asset('assets/svgs/password.svg'),
                          ),
                          controller: _passwordController2,
                          isPasswordField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!_isPasswordEightCharacters) {
                              return 'Password must be at least 8 characters';
                            }
                            if (!_hasPasswordOneNumber) {
                              return 'Password must contain at least one number';
                            }
                            if (!_hasPasswordSpecialCharacter) {
                              return 'Password must contain at least one special character';
                            }
                            if (!_isPasswordUpperLetter) {
                              return 'Password must contain at least one uppercase letter';
                            }
                            if (!_isPAsswordLowerLetter) {
                              return 'Password must contain at least one lowercase letter';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            // First container - Always turns blue if there's any input
                            Container(
                              width: 104,
                              height: 5,
                              decoration: BoxDecoration(
                                color: _passwordController1.text.isNotEmpty ||
                                        _passwordController2.text.isNotEmpty
                                    ? colorBlue
                                    : grey300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(width: 16),
                            // Second container - Turns blue if at least two validations pass
                            Container(
                              width: 104,
                              height: 5,
                              decoration: BoxDecoration(
                                color: _isPasswordEightCharacters &&
                                        _isPasswordUpperLetter &&
                                        _isPAsswordLowerLetter
                                    ? colorBlue
                                    : grey300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(width: 16),
                            // Third container - Turns blue if all validations pass
                            Container(
                              width: 104,
                              height: 5,
                              decoration: BoxDecoration(
                                color: _hasPasswordOneNumber &&
                                        _hasPasswordSpecialCharacter
                                    ? colorBlue
                                    : grey300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Password must:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: colorDarkBlue,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: _isPasswordEightCharacters
                                            ? colorBlue
                                            : Colors.transparent,
                                        border: _isPasswordEightCharacters
                                            ? Border.all(
                                                color: Colors.transparent)
                                            : Border.all(
                                                color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Be at least 8 characters long',
                                    style: TextStyle(
                                        color: greyPassword,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: _hasPasswordOneNumber
                                            ? colorBlue
                                            : Colors.transparent,
                                        border: _hasPasswordOneNumber
                                            ? Border.all(
                                                color: Colors.transparent)
                                            : Border.all(color: colorBlue),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Have at least 1 uppercase',
                                    style: TextStyle(
                                        color: greyPassword,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: _hasPasswordSpecialCharacter
                                            ? colorBlue
                                            : Colors.transparent,
                                        border: _hasPasswordSpecialCharacter
                                            ? Border.all(
                                                color: Colors.transparent)
                                            : Border.all(
                                                color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Have at least 1 lowercase',
                                    style: TextStyle(
                                        color: greyPassword,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: _hasPasswordSpecialCharacter
                                            ? colorBlue
                                            : Colors.transparent,
                                        border: _hasPasswordSpecialCharacter
                                            ? Border.all(
                                                color: Colors.transparent)
                                            : Border.all(
                                                color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Have at least 1 special charactere',
                                    style: TextStyle(
                                        color: greyPassword,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: _hasPasswordSpecialCharacter
                                            ? colorBlue
                                            : Colors.transparent,
                                        border: _hasPasswordSpecialCharacter
                                            ? Border.all(
                                                color: Colors.transparent)
                                            : Border.all(
                                                color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Have at least 1 number',
                                    style: TextStyle(
                                        color: greyPassword,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(height: 81),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
  text: 'Confirm New Password',
  onPressed: _isButtonEnabled ? _handleResetPassword : null,
),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
