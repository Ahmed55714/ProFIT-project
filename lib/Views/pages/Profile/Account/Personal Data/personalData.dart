import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/controller/diet_assessment_controller.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../../widgets/General/customBotton.dart';
import 'controller/presonal_data_controller.dart';

class PersonalDataScreen extends StatefulWidget {
  PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final PersonalDataController personalDataController = Get.find<PersonalDataController>();
  final DietAssessmentController dietAssessmentController = Get.put(DietAssessmentController());
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    personalDataController.fetchUserProfile();
    dietAssessmentController.loadDietAssessment();
  }

  int? openDropdownIndex;

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
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'Personal Data',
        isShowFavourite: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24),
                    Obx(() {
                      if (dietAssessmentController.isLoading.value) {
                        return Center(
                          child: CustomLoder(),
                        );
                      }
                      return AnimatedTextField(
                        singleSelection: true,
                        label: 'Gender',
                        controller: personalDataController.genderController,
                        dropdownItems: dietAssessmentController.genders,
                        isDropdownOpen: openDropdownIndex == 0,
                        onDropdownToggle: () => toggleDropdown(0),
                        suffix: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                        ),
                        onChanged: (values) {
                          personalDataController.genderController.text = values.join(' . ');
                        },
                      );
                    }),
                    AnimatedTextField(
                      label: 'BirthDate',
                      controller: personalDataController.birthDateController,
                    ),
                    AnimatedTextField(
                      label: 'Weight',
                      controller: personalDataController.weightController,
                    ),
                    AnimatedTextField(
                      label: 'Height',
                      controller: personalDataController.heightController,
                    ),
                    AnimatedTextField(
                      label: 'Activity Level',
                      controller: personalDataController.activityLevelController,
                    ),
                    SizedBox(height: 105),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButton(
                    text: 'Update Data',
                    isLoading: isSaving,
                    onPressed: isSaving
                        ? null
                        : () async {
                            setState(() {
                              isSaving = true;
                            });

                            await personalDataController.updateUserData();

                            if (mounted) {
                              setState(() {
                                isSaving = false;
                              });
                            }
                          },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
