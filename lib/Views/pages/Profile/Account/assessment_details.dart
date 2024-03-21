import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/General/custom_profile_textFeild.dart';

class AssessmentDetails extends StatelessWidget {
  final String role2;
  const AssessmentDetails({super.key, required this.role2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        titleText: role2 =='0'? 'Diet Workout Details' : 'Diet Workout Details',
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
                    MyInputTextField(
                      title: 'Goal',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                      title: 'Activity Level',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    CustomTextWidget(text: 'Body Measurements'),
                    MyInputTextField(
                      title: 'Weight',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                      title: 'Body Fat',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                      title: 'Waist Area',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                      title: 'Neck Area',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    CustomTextWidget(text: 'Diet Preferences'),
                    MyInputTextField(
                      title: 'Number of Meals',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg',
                        ),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Diet Type',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg',
                        ),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Food Allgeries ',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg',
                        ),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Disease',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/svgs/chevron-small-leftt.svg',
                        ),
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
                    MyInputTextField(
                      title: 'Injuries',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                        title: 'Activity Level',
                        focusNode: FocusNode(),
                        autoCorrect: false,
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg',
                          ),
                        )),
                    CustomTextWidget(text: 'Workout Preferences'),
                    MyInputTextField(
                      title: 'Workout Days',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                    ),
                    MyInputTextField(
                        title: 'Target Muscle',
                        focusNode: FocusNode(),
                        autoCorrect: false,
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg',
                          ),
                        )),
                    MyInputTextField(
                        title: 'Available Tools',
                        focusNode: FocusNode(),
                        autoCorrect: false,
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg',
                          ),
                        )),
                    MyInputTextField(
                        title: 'Workout Location',
                        focusNode: FocusNode(),
                        autoCorrect: false,
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/svgs/chevron-small-leftt.svg',
                          ),
                        )),
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
