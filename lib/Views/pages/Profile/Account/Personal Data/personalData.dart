import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
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
      appBar: CustomAppBar(titleText: 'Personal Data', isShowFavourite: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              MyInputTextField(
                title: 'Gender',
                textEditingController: controller.genderController,
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
              MyInputTextField(
                title: 'BirthDate',
                textEditingController: controller.birthDateController,
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
              MyInputTextField(
                title: 'Weight',
                textEditingController: controller.weightController,
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
              MyInputTextField(
                title: 'Height',
                textEditingController: controller.heightController,
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
              MyInputTextField(
                title: 'Activity Level',
                textEditingController: controller.activityLevelController,
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
              SizedBox(height: 105),
              CustomButton(
                text: 'Update Data',
                isLoading: isSaving,
                onPressed: isSaving
                    ? null
                    : () async {
                        setState(() {
                          isSaving = true;
                        });

                        controller.updateUserData();

                        if (mounted) {
                          setState(() {
                            isSaving = false;
                          });
                        }
                      },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
