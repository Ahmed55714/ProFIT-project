import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/models/user.dart';

import '../../../controllers/signup_controller.dart';
import '../../../services/api_service.dart';
import '../../../utils/colors.dart';
import '../../widgets/customBotton.dart';
import '../../widgets/customTextFeild.dart';
import '../../widgets/custom_back_button.dart';
import '../forgotPasswordScreens/email_verification.dart';
import 'SignIn.dart';

import 'stepProgress.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserController userController = Get.put(UserController());

  bool isChecked = false;

  CountryCode? countryCode;
  final countryPicker = const FlCountryCodePicker();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();

  bool _hasPasswordOneNumber = false;
  bool _hasPasswordSpecialCharacter = false;
  bool _isPasswordEightCharacters = false;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CustomBackButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Header(
                        title1: 'Sign up',
                        title2: 'Join the community of ProFIT',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        name: 'First Name',
                        labelText: 'First Name',
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        fieldHeight: 56,
                        showCharacterCount: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/person.svg'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (value.length < 3 || value.length > 24) {
                            return 'First name must be between 3 and 24 characters';
                          }
                          final regex = RegExp(r'^[a-zA-Z0-9_.]+$');
                          if (!regex.hasMatch(value)) {
                            return 'First name must contain only letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        name: 'LastName',
                        controller: _lastNameController,
                        labelText: 'Last Name',
                        keyboardType: TextInputType.name,
                        showClearIcon: true,
                        fieldHeight: 56,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/person.svg'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          if (value.length < 3 || value.length > 24) {
                            return 'Last name must be between 3 and 24 characters';
                          }
                          final regex = RegExp(r'^[a-zA-Z0-9_.]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Last name must contain only letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final code = await countryPicker.showPicker(
                                  context: context);
                              setState(() {
                                countryCode = code;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: colorDarkBlue,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 72,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: grey50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          child: countryCode != null
                                              ? Image.asset(
                                                  countryCode!.flagUri,
                                                  package:
                                                      'fl_country_code_picker',
                                                )
                                              : Image.asset(
                                                  'assets/images/egypt.png',
                                                ),
                                        ),
                                        const SizedBox(width: 8),
                                        SvgPicture.asset(
                                            'assets/svgs/down.svg'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomTextField(
                              name: '',
                              labelText: 'Phone Number',
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 10, right: 8),
                                child: Text(
                                  countryCode != null
                                      ? countryCode!.dialCode
                                      : '+20',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: colorDarkBlue,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        name: 'Email',
                        labelText: 'Enter your email',
                        keyboardType: TextInputType.name,
                        showClearIcon: true,
                        controller: _emailController,
                        fieldHeight: 56,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/mail.svg'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        name: 'Password',
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        showClearIcon: false,
                        fieldHeight: 56,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/password.svg'),
                        ),
                        controller: _PasswordController,
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // Check if password is at least 8 characters
                          bool isPasswordEightCharacters = value.length >= 8;
                          // Check if password contains at least one number
                          bool hasPasswordOneNumber =
                              value.contains(RegExp(r'[0-9]'));
                          // Check if password contains at least one special character
                          bool hasPasswordSpecialCharacter =
                              value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                          // Update your validation messages based on the conditions
                          if (!isPasswordEightCharacters) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!hasPasswordOneNumber) {
                            return 'Password must contain at least one number';
                          }
                          if (!hasPasswordSpecialCharacter) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isChecked = newValue!;
                          });
                        },
                        activeColor: colorBlue,
                      ),
                      const Text(
                        "I accept the terms & conditions",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: colorBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 66),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorDarkBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 13,
                          color: colorBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Sign up',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String fullPhoneNumber =
                          (countryCode?.dialCode ?? '+20') +
                              _phoneNumberController.text;
                      bool success = await userController.signUp(
                        User(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          password: _PasswordController.text,
                          mobile: fullPhoneNumber,
                          isTrainer: false,
                        ),
                      );
                      if (success) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailVerificationScreen(
                                    email: _emailController.text, role: '0')));
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TermsAndPrivacyText(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
