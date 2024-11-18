import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profit1/Views/widgets/General/animatedTextField/animated_textfield.dart';
import 'package:profit1/utils/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../widgets/General/custom_text.dart';
import '../../../../../widgets/AppBar/custom_appbar.dart';
import '../controller/old_diet_assessment_controller.dart';


class AssessmentDetails extends StatefulWidget {
  final String role2;
  final String assessmentId;
  const AssessmentDetails({super.key, required this.role2, required this.assessmentId});

  @override
  State<AssessmentDetails> createState() => _AssessmentDetailsState();
}

class _AssessmentDetailsState extends State<AssessmentDetails> {
  final OldAssessmentController controller = Get.put(OldAssessmentController());

  @override
  void initState() {
    super.initState();
    controller.fetchOldDietAssessment(widget.assessmentId);
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date); // Updated format
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
          return buildShimmerLoader();
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        var assessment = controller.oldDietAssessment.value;
        if (assessment == null) {
          return const Center(child: Text('No assessment yet'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: widget.role2 == '0'
                ? Column(
                    children: [
                    
                     Text('Assessment Date: ${formatDate(assessment.createdAt)}',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: DArkBlue900),),
                     
                      const SizedBox(height: 16),
                      const CustomTextWidget(text: 'Personal Data'),
                      const SizedBox(height: 8),
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
                      const CustomTextWidget(text: 'Body Measurements'),
                      const SizedBox(height: 8),
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
                      const CustomTextWidget(text: 'Diet Preferences'),
                      const SizedBox(height: 8),
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
                        controller: TextEditingController(text: assessment.foodAllergens.join(' . ')),
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      AnimatedTextField(
                        label: 'Disease',
                        controller: TextEditingController(text: assessment.disease.join(' . ')),
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(
                              'assets/svgs/chevron-small-leftt.svg'),
                        ),
                      ),
                      const CustomTextWidget(text: 'Additional Info'),
                      const SizedBox(height: 8),
                     AnimatedTextField(
  label: 'Goal',
  controller: controller.goalController..text = controller.goalController.text.isEmpty ? 'Build Muscle' : controller.goalController.text,
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
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: DArkBlue900)),
                      const SizedBox(height: 16),
                      const CustomTextWidget(text: 'Experience (Fitness Level)'),
                      const SizedBox(height: 8),
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
                      const CustomTextWidget(text: 'Workout Preferences'),
                      const SizedBox(height: 8),
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

  Widget buildShimmerLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(bottom: 16),
                ),
                for (int i = 0; i < 10; i++)
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.grey[300],
                    margin: EdgeInsets.only(bottom: 16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}