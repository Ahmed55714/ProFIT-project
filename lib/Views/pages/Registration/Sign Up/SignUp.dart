import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/customTextFeild.dart';
import '../../../widgets/General/custom_back_button.dart';
import '../../../widgets/Tearms and privacy/Terms_and_privacy_text.dart';
import '../forgotPasswordScreens/email_verification.dart';
import '../Sign In/SignIn.dart';

import '../Basic Information/Step Progress/stepProgress.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserController userController = Get.put(UserController());
  bool isChecked = false;
  bool isSigningUp = false;

  CountryCode? countryCode;
  final countryPicker = const FlCountryCodePicker();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordSpecialCharacter = false;
  bool _isPasswordEightCharacters = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(() {
      userController.setFirstName(_firstNameController.text);
    });

    _lastNameController.addListener(() {
      userController.setLastName(_lastNameController.text);
    });

    _phoneNumberController.addListener(() {
      userController.setPhoneNumber(_phoneNumberController.text);
    });

    _emailController.addListener(() {
      userController.setEmail(_emailController.text);
    });
    _PasswordController.addListener(() {
      userController.setPassword(_PasswordController.text);
    });

    _PasswordController.addListener(() {
      final password = _PasswordController.text;

      _hasPasswordOneNumber = password.contains(RegExp(r'\d'));

      _hasPasswordSpecialCharacter =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      _isPasswordEightCharacters = password.length >= 8;

      userController.setPassword(password);

      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _PasswordController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

 void _attemptSignUp() async {
  if (_formKey.currentState!.validate() && isChecked) {
    setState(() {
      isSigningUp = true;
    });
    try {
      await userController.signUp();
      var result = await Get.to(() => EmailVerificationScreen(
            role: '0',
            email: _emailController.text,
          ));
      if (result == 'fromVerification') {
        setState(() {
          isSigningUp = false;
        });
      }
    } catch (error) {
      Get.snackbar('Sign Up Error', error.toString());
      setState(() {
        isSigningUp = false;
      });
    }
  } else if (!isChecked) {
    Get.snackbar('Error', 'You must accept the terms and conditions.');
  }
}


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
                        keyboardType: TextInputType.name,
                        controller: _firstNameController,
                        focusNode: _firstNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _lastNameFocusNode.requestFocus();
                        },
                    
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
                        labelText: 'Last Name',
                        keyboardType: TextInputType.name,
                        controller: _lastNameController,
                        focusNode: _lastNameFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _phoneNumberFocusNode.requestFocus();
                        },
                        showClearIcon: true,
                     
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: grey200,)
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
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                              focusNode: _phoneNumberFocusNode,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                _emailFocusNode.requestFocus();
                              },
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
                                // Additional validation as needed
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
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _passwordFocusNode.requestFocus();
                        },
                      
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
                       
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/password.svg'),
                        ),
                        controller: _PasswordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _attemptSignUp();
                        },
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
                const SizedBox(height: 42),
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
                        Get.to(const SignInScreen());
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
                  onPressed: isSigningUp ? null : _attemptSignUp,
                  isLoading: isSigningUp,
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: TermsAndPrivacyText(),
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
