import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../../../widgets/General/custom_profile_textFeild.dart';
import 'controller/presonal_data_controller.dart';

class PersonalDataScreen extends StatefulWidget {
  PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final PersonalDataController controller = Get.find<PersonalDataController>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    controller.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Personal Data',
        isShowFavourite: true,
      ),
      body: Stack(
        children: [
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  AnimatedTextField(
                    label: 'Gender',
                    controller: controller.genderController,
                  ),
                  AnimatedTextField(
                    label: 'BirthDate',
                    controller: controller.birthDateController,
                  ),
                  AnimatedTextField(
                    label: 'Weight',
                    controller: controller.weightController,
                  ),
                  AnimatedTextField(
                    label: 'Height',
                    controller: controller.heightController,
                  ),
                  AnimatedTextField(
                    label: 'Activity Level',
                    controller: controller.activityLevelController,
                  ),
            Expanded(child: SizedBox(height: 105)),
                ],
              ),
            ),
          
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: CustomButton(
              text: 'Update Data',
              isLoading: isSaving,
              onPressed: isSaving
                  ? null
                  : () async {
                      setState(() {
                        isSaving = true;
                      });

                      await controller.updateUserData();

                      if (mounted) {
                        setState(() {
                          isSaving = false;
                        });
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
