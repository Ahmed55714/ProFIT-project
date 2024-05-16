import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/assessment_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';
import '../../../../widgets/General/custom_profile_textFeild.dart';
import 'controller/diet_assessment_controller.dart';

class DietAssessment extends StatefulWidget {
  const DietAssessment({super.key});

  @override
  State<DietAssessment> createState() => _DietAssessmentState();
}

class _DietAssessmentState extends State<DietAssessment> {
  final DietAssessmentController controller = Get.put(DietAssessmentController());

  @override
  void initState() {
    super.initState();
    controller.loadDietAssessment();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        }
        var assessment = controller.dietAssessment.value;
        if (assessment == null) {
          return Center(child: Text('Failed to load assessment data'));
        }
        return TabBarView(
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
                      initValue: assessment.fitnessGoals,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Activity Level',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.activityLevel,
                      isdropMenu: true,
                      isShowChange: true,
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
                      initValue: assessment.weight.toString(),
                    ),
                    MyInputTextField(
                      title: 'Body Fat',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.bodyFat.toString(),
                    ),
                    MyInputTextField(
                      title: 'Waist Area',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.waistArea.toString(),
                    ),
                    MyInputTextField(
                      title: 'Neck Area',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.neckArea.toString(),
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
                      initValue: assessment.numberOfMeals.toString(),
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Diet Type',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.dietType,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Food Allergies',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.foodAllergens.join(', '),
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    MyInputTextField(
                      title: 'Disease',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      initValue: assessment.disease.join(', '),
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

