import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../services/api_service.dart';

import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/customTextFeild.dart';
import '../../../widgets/General/custom_back_button.dart';
import 'email_verification.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // To manage the loading state

  Future<void> _handleSendCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      bool isSent =
          await ApiService().forgotPassword(_emailController.text.trim());

      setState(() => _isLoading = false);
      if (isSent) {
        Get.to(
            EmailVerificationScreen(email: _emailController.text, role: '1'));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to send reset code. Please try again.')));
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
                        onPressed: () => Navigator.pop(context),
                      ),
                      Header(
                          title1: 'Forgot Password',
                          title2:
                              'Enter the email associated with your account'),
                      const SizedBox(height: 46),
                      const CustomImageWidget(
                          imagePath: 'assets/images/3dicons.png'),
                      const SizedBox(height: 26),
                      CustomTextField(
                        name: 'Email',
                        labelText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        showClearIcon: true,
                        controller: _emailController,
                 
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                         textInputAction: TextInputAction.done,
  onFieldSubmitted: (value) {
    if (!_isLoading) _handleSendCode(); 
  },
                      ),
                      const SizedBox(height: 281),
                      CustomButton(
                        text: 'Send Code',
                        onPressed: _isLoading ? null : _handleSendCode,
                        isLoading: _isLoading,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
