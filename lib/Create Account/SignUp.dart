import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../widgets/customBotton.dart';
import '../widgets/customTextFeild.dart';
import '../widgets/custom_back_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;

  CountryCode? countryCode;
  final countryPicker = FlCountryCodePicker();
   final _formKey = GlobalKey<FormState>(); 

  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _hasPasswordOneNumber = false;
  bool _hasPasswordSpecialCharacter = false;
  bool _isPasswordEightCharacters = false;
  bool _isVisible = false;




  void _updateButtonState() {
    final emailNotEmpty = _emailController.text.isNotEmpty;
    final passwordNotEmpty = _PasswordController.text.isNotEmpty;

    _isPasswordEightCharacters = _PasswordController.text.length >= 8;
    _hasPasswordOneNumber =
        _PasswordController.text.contains(RegExp(r'\d')); // Checks for digits
    _hasPasswordSpecialCharacter =
        _PasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    final isFormValid = emailNotEmpty && passwordNotEmpty ||
        _isPasswordEightCharacters ||
        _hasPasswordOneNumber ||
        _hasPasswordSpecialCharacter;

    setState(() {
      _isVisible = isFormValid;
    });
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
                      SizedBox(
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
                      Text(
                        'Sign up',
                        style: TextStyle(
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
                        'Join the community of ProFit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colorDarkBlue,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        name: 'First Name',
                        labelText: 'First Name',
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
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: colorDarkBlue,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 72,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: grey50,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Colors.grey.shade400),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                        SizedBox(width: 8),
                                        SvgPicture.asset('assets/svgs/down.svg'),
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
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 10, right: 8),
                                child: Text(
                                  countryCode != null
                                      ? countryCode!.dialCode
                                      : '+20',
                                  style: TextStyle(
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
                      Text(
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
               SizedBox(height: 66),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorDarkBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
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
                SizedBox(height: 16),
                CustomButton(text: 'Sign up', onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    print('Validated');
                  }
                }),
                SizedBox(height: 16),
                 Center(
                   child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: const TermsAndPrivacyText(),
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
