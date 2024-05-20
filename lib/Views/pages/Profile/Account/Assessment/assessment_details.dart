import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import 'controller/diet_assessment_controller.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/General/animatedTextField/animated_textfield.dart';

class AssessmentDetails extends StatelessWidget {
  final String role2;
  const AssessmentDetails({super.key, required this.role2});

  @override
  Widget build(BuildContext context) {
    final DietAssessmentController controller =
        Get.find<DietAssessmentController>();

    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: role2 == '0' ? 'Diet Details' : 'Workout Details',
        isShowFavourite: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          print(controller.errorMessage.value);
          return Center(child: Text(controller.errorMessage.value));
        }

        var assessment = controller.oldDietAssessment.value;
        if (assessment == null) {
          return Center(child: Text('No assessment data found'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        initialValue: assessment.fitnessGoals,
                      ),
                      AnimatedTextField(
                        label: 'Activity Level',
                        initialValue: assessment.activityLevel,
                      ),
                      CustomTextWidget(text: 'Body Measurements'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Weight',
                        initialValue: assessment.weight.toString(),
                      ),
                      AnimatedTextField(
                        label: 'Body Fat',
                        initialValue: assessment.bodyFat.toString(),
                      ),
                      AnimatedTextField(
                        label: 'Waist Area',
                        initialValue: assessment.waistArea.toString(),
                      ),
                      AnimatedTextField(
                        label: 'Neck Area',
                        initialValue: assessment.neckArea.toString(),
                      ),
                      CustomTextWidget(text: 'Diet Preferences'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Number of Meals',
                        initialValue: assessment.numberOfMeals.toString(),
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Diet Type',
                        initialValue: assessment.dietType,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Food Allergies',
                        initialValue: assessment.foodAllergens.join(', '),
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Disease',
                        initialValue: assessment.disease.join(', '),
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
                        initialValue: assessment.disease.join(
                            ', '), // Assuming this is the correct field for injuries
                      ),
                      AnimatedTextField(
                        label: 'Activity Level',
                        initialValue: assessment.activityLevel,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      CustomTextWidget(text: 'Workout Preferences'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Workout Days',
                        initialValue:
                            '', // Placeholder as there is no equivalent field in OldDietAssessment
                      ),
                      AnimatedTextField(
                        label: 'Target Muscle',
                        initialValue:
                            '', // Placeholder as there is no equivalent field in OldDietAssessment
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Available Tools',
                        initialValue:
                            '', // Placeholder as there is no equivalent field in OldDietAssessment
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Workout Location',
                        initialValue:
                            '', // Placeholder as there is no equivalent field in OldDietAssessment
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
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
