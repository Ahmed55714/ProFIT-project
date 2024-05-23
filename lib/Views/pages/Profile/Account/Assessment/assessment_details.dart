import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profit1/Views/widgets/General/animatedTextField/animated_textfield.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:profit1/utils/colors.dart';
import 'controller/diet_assessment_controller.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';

class AssessmentDetails extends StatefulWidget {
  final String role2;
  const AssessmentDetails({super.key, required this.role2});

  @override
  State<AssessmentDetails> createState() => _AssessmentDetailsState();
}

class _AssessmentDetailsState extends State<AssessmentDetails> {
  final OldAssessmentController controller = Get.put(OldAssessmentController());

  @override
  void initState() {
    super.initState();
    controller.fetchOldDietAssessment();
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: widget.role2 == '0' ? 'Diet Details' : 'Workout Details',
        isShowFavourite: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CustomLoder(
            color: colorBlue,
            size: 35,
          ));
        }

        if (controller.errorMessage.value.isNotEmpty) {
          print(controller.errorMessage.value);
          return Center(child: Text(controller.errorMessage.value));
        }

        var assessment = controller.oldDietAssessment.value;
        if (assessment == null) {
          return Center(child: Text('No assessment yet'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: widget.role2 == '0'
                ? Column(
                    children: [
                      Text('Assessment Date: ${formatDate(assessment.createdAt)}',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: DArkBlue900)),
                      SizedBox(height: 16),
                      CustomTextWidget(text: 'Personal Data'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Gender',
                        controller: controller.genderController,
                      ),
                      AnimatedTextField(
                        label: 'Birth Date',
                        controller: TextEditingController(text: formatDate(assessment.birthDate)),
                      ),
                      AnimatedTextField(
                        label: 'Height',
                        controller: controller.heightController,
                      ),
                      CustomTextWidget(text: 'Body Measurements'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Weight',
                        controller: controller.weightController,
                      ),
                      AnimatedTextField(
                        label: 'Body Fat',
                        controller: controller.bodyFatController,
                      ),
                      AnimatedTextField(
                        label: 'Waist Area',
                        controller: controller.waistAreaController,
                      ),
                      AnimatedTextField(
                        label: 'Neck Area',
                        controller: controller.neckAreaController,
                      ),
                      CustomTextWidget(text: 'Diet Preferences'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Number of Meals',
                        controller: controller.numberOfMealsController,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Diet Type',
                        controller: controller.dietTypeController,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Food Allergies',
                        controller: controller.foodAllergensController,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Disease',
                        controller: controller.diseaseController,
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      CustomTextWidget(text: 'Additional Info'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Goal',
                        controller: controller.goalController,
                      ),
                      AnimatedTextField(
                        label: 'Activity Level',
                        controller: controller.activityLevelController,
                      ),
                     
                    ],
                  )
                : Column(
                    children: [
                      Text('Assessment Date: ${formatDate(assessment.createdAt)}',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: DArkBlue900)),
                      SizedBox(height: 16),
                      CustomTextWidget(text: 'Experience (Fitness Level)'),
                      SizedBox(height: 8),
                      AnimatedTextField(
                        label: 'Injuries',
                        controller: controller.diseaseController,
                      ),
                      AnimatedTextField(
                        label: 'Activity Level',
                        controller: controller.activityLevelController,
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
                        initialValue: '',
                      ),
                      AnimatedTextField(
                        label: 'Target Muscle',
                        initialValue: '',
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Available Tools',
                        initialValue: '',
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Workout Location',
                        initialValue: '',
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
            color: DArkBlue900,
          ),
        ),
      ],
    );
  }
}
