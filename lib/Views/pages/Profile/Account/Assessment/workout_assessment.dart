import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/assessment_details.dart';

import '../../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../../widgets/General/custom_profile_textFeild.dart';

class WorkOutAssessment extends StatefulWidget {
  const WorkOutAssessment({super.key});

  @override
  State<WorkOutAssessment> createState() => _WorkOutAssessmentState();
}

class _WorkOutAssessmentState extends State<WorkOutAssessment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextWidget(text: 'Background'),
                  AnimatedTextField(
                    label: 'Experience (Fitness Level)',
                  ),
                  AnimatedTextField(
                    label: 'Injuries',
                    suffix: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextWidget(text: 'Workout Preferences'),
                 SizedBox(height: 8),
                  AnimatedTextField(
                    label: 'Workout Days',
                  ),
                  AnimatedTextField(
                    label: 'Target Muscle',
                    suffix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg'),
                    ),
                  ),
                  AnimatedTextField(
                    label: 'Avilable Tools',
                    suffix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg'),
                    ),
                  ),
                  AnimatedTextField(
                    label: 'Workout Location',
                    suffix: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg'),
                    ), text: '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
