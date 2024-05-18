import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../../widgets/General/custom_profile_textFeild.dart';

class AssessmentDetails extends StatelessWidget {
  final String role2;
  const AssessmentDetails({super.key, required this.role2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText:
            role2 == '0' ? 'Diet Details' : 'Workout Details',
        isShowFavourite: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: role2 == '0'
              ? Column(
                  children: [
                    Text('Tuesday, 15 Sep 2023',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: DArkBlue900)),
                    SizedBox(height: 16),
                   
                    CustomTextWidget(text: 'Personal data'),
                   SizedBox(height: 8),
                    AnimatedTextField(
                      label: 'Goal',
                    ),
                    AnimatedTextField(
                      label: 'Activity Level',
                    ),
                    CustomTextWidget(text: 'Body Measurements'),
                   SizedBox(height: 8),
                    AnimatedTextField(
                      label: 'weight',
                    ),
                    AnimatedTextField(
                      label: 'Body Fat',
                    ),
                    AnimatedTextField(
                      label: 'waist Area',
                    ),
                    AnimatedTextField(
                      label: 'Neck Area',
                    ),
                    CustomTextWidget(text: 'Diet Preferences'),
                   SizedBox(height: 8),
                    AnimatedTextField(
                      label: 'Number of Meals',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    AnimatedTextField(
                      label: 'Diet Type',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    AnimatedTextField(
                      label: 'Food Allergies',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    AnimatedTextField(
                      label: 'Disease',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text('Tuesday, 15 Sep 2023',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: DArkBlue900)),
                    SizedBox(height: 16),
                    CustomTextWidget(text: 'Experience (Fitness Level)'),
                    SizedBox(height: 8),
                       AnimatedTextField(
                     label: 'Injuries',
                        ),
                        AnimatedTextField(
                     label: 'Activity Level',
                        
                       
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                    CustomTextWidget(text: 'Workout Preferences'),
                      SizedBox(height: 8),
                       AnimatedTextField(
                     label: 'Workout Days',
                       
                        ),
                       AnimatedTextField(
                     label: 'Target Muscle',
                       
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                       AnimatedTextField(
                     label: 'Avilable Tools',
                       
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                       AnimatedTextField(
                     label: 'Workout Location',
                       
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String text;

  const CustomTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: DArkBlue900, // Assuming DArkBlue900 is defined somewhere
          ),
        ),
      ],
    );
  }
}
