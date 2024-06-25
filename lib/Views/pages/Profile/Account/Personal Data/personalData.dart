import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: colorBlue,
            hintColor: colorBlue,
            colorScheme: ColorScheme.light(primary: colorBlue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        personalDataController.birthDateController.text = formattedDate;
      });
    }
  }

  Widget buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
           Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
            Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'Personal Data',
        isShowFavourite: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 72.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24),
                    Obx(() {
                      if (dietAssessmentController.isLoading.value) {
                        return buildSkeletonLoader();
                      }
                      return Column(
                        children: [
                          AnimatedTextField(
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
                          ),
                          AnimatedTextField(
                            label: 'BirthDate',
                            controller: personalDataController.birthDateController,
                            isShowCalendar: true,
                            suffix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  color: colorBlue,
                                ),
                              ),
                            ),
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
                            singleSelection: true,
                            label: 'Activity Level',
                            controller: personalDataController.activityLevelController,
                            dropdownItems: dietAssessmentController.activityLevels,
                            isDropdownOpen: openDropdownIndex == 1,
                            onDropdownToggle: () => toggleDropdown(1),
                            suffix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                            ),
                            onChanged: (values) {
                              personalDataController.activityLevelController.text = values.join(' . ');
                            },
                          ),
                          AnimatedTextField(
                            singleSelection: true,
                            label: 'Goal',
                            dropdownItems: dietAssessmentController.fitnessGoals,
                            controller: personalDataController.goalController,
                            isDropdownOpen: openDropdownIndex == 2,
                            onDropdownToggle: () => toggleDropdown(2),
                            suffix: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset('assets/svgs/chevron-small-leftt.svg'),
                            ),
                            onChanged: (values) {
                              personalDataController.goalController.text = values.join(' . ');
                            },
                          ),
                          SizedBox(height: 105),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (!dietAssessmentController.isLoading.value) {
                return Align(
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
                );
              } else {
                return SizedBox.shrink(); // Returns an empty box when loading
              }
            }),
          ],
        ),
      ),
    );
  }
}
