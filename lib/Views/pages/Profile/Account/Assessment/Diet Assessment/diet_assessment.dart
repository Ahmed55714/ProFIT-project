import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/controller/diet_assessment_controller.dart';
import '../../../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../../../widgets/General/custom_text.dart';

class DietAssessment extends StatefulWidget {
  const DietAssessment({super.key});

  @override
  State<DietAssessment> createState() => _DietAssessmentState();
}

class _DietAssessmentState extends State<DietAssessment> {
  final DietAssessmentController controller = Get.put(DietAssessmentController());

  int? openDropdownIndex;

  @override
  void initState() {
    super.initState();
    controller.loadDietAssessment();
  }

  void toggleDropdown(int index) {
    setState(() {
      if (openDropdownIndex == index) {
        openDropdownIndex = null;
      } else {
        openDropdownIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextWidget(text: 'Personal data'),
                SizedBox(height: 8),
                AnimatedTextField(
                    singleSelection:true,
                  label: 'Goal',
                  dropdownItems: controller.fitnessGoals,
                  controller: controller.goalController,
                  index: 0,
                  isDropdownOpen: openDropdownIndex == 0,
                  onDropdownToggle: () => toggleDropdown(0),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                ),
                AnimatedTextField(
                    singleSelection:true,
                  label: 'Activity Level',
                  dropdownItems: controller.activityLevels,
                  controller: controller.activityLevelController,
                  index: 1,
                  isDropdownOpen: openDropdownIndex == 1,
                  onDropdownToggle: () => toggleDropdown(1),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextWidget(text: 'Body Measurements'),
                SizedBox(height: 8),
                AnimatedTextField(
                  label: 'Weight',
                  controller: controller.weightController,
                  index: 2,
                  isDropdownOpen: openDropdownIndex == 2,
                  onDropdownToggle: () => toggleDropdown(2),
                ),
                AnimatedTextField(
                  label: 'Body Fat',
                  controller: controller.bodyFatController,
                  index: 3,
                  isDropdownOpen: openDropdownIndex == 3,
                  onDropdownToggle: () => toggleDropdown(3),
                ),
                AnimatedTextField(
                  label: 'Waist Area',
                  controller: controller.waistAreaController,
                  index: 4,
                  isDropdownOpen: openDropdownIndex == 4,
                  onDropdownToggle: () => toggleDropdown(4),
                ),
                AnimatedTextField(
                  label: 'Neck Area',
                  controller: controller.neckAreaController,
                  index: 5,
                  isDropdownOpen: openDropdownIndex == 5,
                  onDropdownToggle: () => toggleDropdown(5),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextWidget(text: 'Diet Preferences'),
                SizedBox(height: 8),
                AnimatedTextField(
                    singleSelection:true,
                  label: 'Number of Meals',
                  dropdownItems: controller.numberOfMeals,
                  controller: controller.numberOfMealsController,
                  index: 6,
                  isDropdownOpen: openDropdownIndex == 6,
                  onDropdownToggle: () => toggleDropdown(6),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                ),
                AnimatedTextField(
                    singleSelection:true,
                  label: 'Diet Type',
                  dropdownItems: controller.dietTypes,
                  controller: controller.dietTypeController,
                  index: 7,
                  isDropdownOpen: openDropdownIndex == 7,
                  onDropdownToggle: () => toggleDropdown(7),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                ),
                AnimatedTextField(
                  
                  label: 'Food Allergies',
                  dropdownItems: controller.foodAllergens,
                  controller: controller.foodAllergensController,
                  index: 8,
                  isDropdownOpen: openDropdownIndex == 8,
                  onDropdownToggle: () => toggleDropdown(8),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                  onChanged: (values) {
                    controller.foodAllergensController.text = values.join(' . ');
                  },
                ),
                AnimatedTextField(
                  label: 'Disease',
                  dropdownItems: controller.diseases,
                  controller: controller.diseaseController,
                  index: 9,
                  isDropdownOpen: openDropdownIndex == 9,
                  onDropdownToggle: () => toggleDropdown(9),
                  suffix: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                  ),
                  onChanged: (values) {
                    controller.diseaseController.text = values.join(' . ');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
