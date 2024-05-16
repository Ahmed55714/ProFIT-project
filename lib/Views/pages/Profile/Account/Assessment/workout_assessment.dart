import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/assessment_details.dart';

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
                                MyInputTextField(
                                  title: 'Experience (Fitness Level)',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                ),
                                MyInputTextField(
                                  title: 'Injuries',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
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
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Available Tools',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Workout Location',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
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
                      ],
                    ),
                  );
  }
}