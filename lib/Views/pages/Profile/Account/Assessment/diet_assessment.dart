import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/assessment_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../services/api_service.dart';
import '../../../../widgets/General/animatedTextField/animated_textfield.dart';
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
      child: TabBarView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomTextWidget(text: 'Personal data'),
                   SizedBox(height: 8),
                    AnimatedTextField(
                      label: 'Goal',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                      ),
                    ),
                    AnimatedTextField(
                     label: 'Activity Level',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
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
                    SizedBox(height: 8),
                    AnimatedTextField(
                     label: 'Number of Meals',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                     AnimatedTextField(
                     label: 'Diet Type',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                      AnimatedTextField(
                     label: 'Food Allergies',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
                    ),
                      AnimatedTextField(
                     label: 'Disease',
                      suffix: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),),
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


