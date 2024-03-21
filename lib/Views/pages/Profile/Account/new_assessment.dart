import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/pages/Profile/Account/assessment_details.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../../widgets/General/custom_profile_textFeild.dart';

class NewAssessmentsScreen extends StatelessWidget {
  final String role2;
  const NewAssessmentsScreen({Key? key, required this.role2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:
          role2 == '0' ? 3 : 2, // Update the length based on the role2 value
      child: Scaffold(
        appBar: CustomAppBar(
          titleText:
              role2 == '0' ? 'New Diet Assessments' : 'New Workout Assessments',
          isShowFavourite: true,
          isShowProfile: true,
        ),
        body: Column(
          children: [
            role2 == '0'
                ? CustomTabBar(
                    tabTexts: ['Personal data', 'Measurements', 'Preferences'],
                  )
                : CustomTabBar(
                    isShowFavourite: true,
                    tabTexts: ['Background', 'Preferences'],
                  ),
            role2 == '0'
                ? Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomTextWidget(text: 'Personal data'),
                                MyInputTextField(
                                  title: 'Goal',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Activity Level',
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomTextWidget(text: 'Diet Preferences'),
                                MyInputTextField(
                                  title: 'Number of Meals',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Diet Type',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Food Allgeries ',
                                  focusNode: FocusNode(),
                                  autoCorrect: false,
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                        'assets/svgs/chevron-small-leftt.svg'),
                                  ),
                                ),
                                MyInputTextField(
                                  title: 'Disease',
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
                  )
                : Expanded(
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
                  ),
            CustomButton(
              text: 'Submit Assessment',
              onPressed: () {
                _showSendAssessmentConfirmation(context);
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void _showSendAssessmentConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Are you sure you\'re ready to proceed?',
                onCancelPressed: () => Navigator.pop(context),
              ),
              Image.asset('assets/images/3diconssw.png'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Your progress is important to us, and we want to make sure everything is accurate.',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: DArkBlue900,
                          ),
                          maxLines: 3, // Adjust as needed
                          textAlign: TextAlign.center, // Adjust text alignment
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(
                  text: 'Yes',
                  onPressed: () {
                    Navigator.pop(context);
                    _showSubmittedAssessmentConfirmation(context);
                  }),
              const SizedBox(height: 8),
              CustomButton(text: 'No', onPressed: () {}, isShowDifferent: true),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

void _showSubmittedAssessmentConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.38,
          ),
          child: Column(
            children: <Widget>[
              Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: grey600,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 59,
            height: 5,
          ),
          SizedBox(height: 16),
              Image.asset('assets/images/true.png'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Wrap(
                      children: [
                        Text(
                          'Diet Assessment has been successfully submitted',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: DArkBlue900,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                        
                      ],
                    ),
                    Text(
                          'Your Coach will customized your plan ',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: grey400,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Go to Home', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}
