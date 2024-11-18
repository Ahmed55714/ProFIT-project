import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';

class TermsAndPolicies extends StatelessWidget {
  const TermsAndPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Terms and Policies',
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 19),
              Row(
                children: [
                  Text('Last updated: 15st June 2024',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              TermsSection(
                title: '1. Introduction',
                content: 'Welcome to our fitness platform. These terms and conditions outline the rules and regulations for the use of our platform. By accessing this platform, you accept these terms and conditions in full.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '2. Intellectual Property Rights',
                content: 'Unless otherwise stated, we or our licensors own the intellectual property rights in the platform and material on the platform. All these intellectual property rights are reserved.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '3. User Account',
                content: 'To access certain features of the platform, you may be required to create an account. You agree to provide accurate and complete information and to update such information as necessary.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '4. User Obligations',
                content: 'You must use the platform in a responsible manner and must not use it in any way that causes or is likely to cause the platform or access to it to be interrupted, damaged, or impaired in any way.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '5. Limitation of Liability',
                content: 'We will not be liable to you in respect of any loss or damage arising out of any event or events beyond our reasonable control.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '6. Changes to Terms',
                content: 'We may revise these terms and conditions from time-to-time. Revised terms and conditions will apply to the use of our platform from the date of the publication of the revised terms and conditions on our platform.',
              ),
              SizedBox(height: 16),
              TermsSection(
                title: '7. Governing Law',
                content: 'These terms and conditions are governed by and construed in accordance with the laws of [Your Country], and you irrevocably submit to the exclusive jurisdiction of the courts in that State or location.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const TermsSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: DArkBlue900,
          ),
        ),
       
        const Divider(
          color: grey200,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: grey500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
