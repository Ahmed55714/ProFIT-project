import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/animatedTextField/animated_textfield.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import '../../../../../utils/colors.dart';
import 'controller/diet_assessment_controller.dart';

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
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CustomLoder(
            color: colorBlue,
            size: 35,
          ),
        );
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      return Expanded(
        child: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomTextWidget(text: 'Personal data'),
                    SizedBox(height: 8),
                    AnimatedTextField(
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
                      index: 2,
                      isDropdownOpen: openDropdownIndex == 2,
                      onDropdownToggle: () => toggleDropdown(2),
                    ),
                    AnimatedTextField(
                      label: 'Body Fat',
                      index: 3,
                      isDropdownOpen: openDropdownIndex == 3,
                      onDropdownToggle: () => toggleDropdown(3),
                    ),
                    AnimatedTextField(
                      label: 'Waist Area',
                      index: 4,
                      isDropdownOpen: openDropdownIndex == 4,
                      onDropdownToggle: () => toggleDropdown(4),
                    ),
                    AnimatedTextField(
                      label: 'Neck Area',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
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
