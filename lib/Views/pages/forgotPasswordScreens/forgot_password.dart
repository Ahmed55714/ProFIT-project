import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../services/api_service.dart';
import '../../widgets/General/customBotton.dart';
import '../../widgets/General/customTextFeild.dart';
import '../../widgets/General/custom_back_button.dart';
import 'email_verification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  // @override
  // void dispose() {
  //   _emailController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBackButton(
                        showBackground: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Header(
                          title1: 'Forgot Password',
                          title2:
                              'Enter the email associated with your account'),
                      const SizedBox(
                        height: 46,
                      ),
                      const CustomImageWidget(
                        imagePath: 'assets/images/3dicons.png',
                      ),
                      const SizedBox(
                        height: 26,
                      ),
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
                      const SizedBox(
                        height: 281,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                  text: 'Send Code',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool isSent = await ApiService()
                          .forgotPassword(_emailController.text);
                      if (isSent) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen(
                                email: _emailController.text, role: '1'),
                          ),
                        );
                        
                      } 
                    }
                  }),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
